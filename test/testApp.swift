//
//  testApp.swift
//  test
//
//  Created by Conrad Irwin on 9/6/24.
//

import SwiftUI
import AppKit
import Carbon

import ObjectiveC

struct CustomCommands: Commands {
    var body: some Commands {
        CommandGroup(after: .newItem) {
            ForEach(33...126, id: \.self) { asciiValue in
                if let scalar = UnicodeScalar(asciiValue) {
                    let character = String(scalar)
                    let shift = if character.lowercased() != character{
                        EventModifiers.shift
                    } else {
                        EventModifiers.shift.subtracting(EventModifiers.shift)
                    };

                    Button(character) {
 
                    }
                    .keyboardShortcut(KeyEquivalent(Character(character)), modifiers: [shift.union(.command)])
                }
            }
        }
    }
}

func determineShift(_ key: String, inputSource: TISInputSource) -> String {
    guard let layoutData = TISGetInputSourceProperty(inputSource, kTISPropertyUnicodeKeyLayoutData) else {
        print("no layout data");
        return "no layout data"
    }
    let dataRef = unsafeBitCast(layoutData, to: CFData.self)
    let keyboardLayout = unsafeBitCast(CFDataGetBytePtr(dataRef), to: UnsafePointer<UCKeyboardLayout>.self)
    
    let char = key.unicodeScalars.first!;
    for keyCode in UInt16(0)...UInt16(53) {
        let with_cmd = charactersWithModifiers(keyboardLayout: keyboardLayout, keyCode: keyCode, shift: false, cmd: true);
        if with_cmd == char {
            return String(charactersWithModifiers(keyboardLayout: keyboardLayout, keyCode: keyCode, shift: true, cmd: false));
        }
    }
    return "not found"
}



func printDifferences(menu: NSMenu, inputSource: TISInputSource) {

    var differences: [String:String] = [:];
    
    for item in menu.items {
        if let submenu = item.submenu {
            printDifferences(menu: submenu, inputSource: inputSource)
            return
        }
            let shift = item.keyEquivalentModifierMask.contains(.shift);
            var key = item.keyEquivalent
            if key == "" {
                key = "missing"
            } else
                        
            if shift {
                if String(key).uppercased() != String(key) {
                    key = String(key).uppercased()
                } else {
                    key = determineShift(key, inputSource: inputSource)
                }
            }
        if item.title != key {
            differences[item.title] = key
        }
    }
    do {
        
        let inputSourceID = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID).map {
            unsafeBitCast($0, to: CFString.self) as String
        } ?? "Unknown"
        let jsonData = try JSONEncoder().encode([inputSourceID:differences])

        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    } catch {
        print("Failed to encode JSON: \(error)")
    }
}

func charactersWithModifiers(keyboardLayout: UnsafePointer<UCKeyboardLayout>, keyCode: UInt16, shift: Bool, cmd: Bool) -> UnicodeScalar {
    var modifiers = UInt32(0);
    if cmd {
        modifiers |= UInt32(cmdKey >> 8);
    }
    if shift {
        modifiers |= UInt32(shiftKey >> 8);
    }
    
    var deadKeyState: UInt32 = 0
    var chars = [UniChar](repeating: 0, count: 4)
    var length = 0
    
    var status = UCKeyTranslate(
        keyboardLayout,
        UInt16(keyCode),
        UInt16(kUCKeyActionDown),
        modifiers,
        UInt32(LMGetKbdType()),
        UInt32(kUCKeyTranslateNoDeadKeysBit),
        &deadKeyState,
        4,
        &length,
        &chars
    );
    
    if (status == noErr && length == 0 && deadKeyState != 0) {
      status = UCKeyTranslate(
          keyboardLayout,
          UInt16(keyCode),
          UInt16(kUCKeyActionDown),
          modifiers,
          UInt32(LMGetKbdType()),
          UInt32(kUCKeyTranslateNoDeadKeysBit),
          &deadKeyState,
          4,
          &length,
          &chars);
    }
    
    if status == noErr &&  length > 0 {
        let string = String(utf16CodeUnits: chars, count: length);
        return string.unicodeScalars.first!;
    } else {
        return " ".unicodeScalars.first!
    }
}


func getNonASCIICapableInputSources() -> [TISInputSource] {
    // Get all input sources
    guard let inputSources = TISCreateInputSourceList(nil, true)?.takeRetainedValue() as? [TISInputSource] else {
        print("Failed to get input sources")
        return []
    }
    
    let asciiGraphicalRange:  Set<UInt32> = Set(33...126);
    
    var todo: [TISInputSource] = [];
    
    for inputSource in inputSources {
        guard let layoutData = TISGetInputSourceProperty(inputSource, kTISPropertyUnicodeKeyLayoutData) else {
            continue
        }
        let inputSourceName = TISGetInputSourceProperty(inputSource, kTISPropertyLocalizedName).map {
            unsafeBitCast($0, to: CFString.self) as String
        } ?? "Unknown"
        let inputSourceID = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID).map {
            unsafeBitCast($0, to: CFString.self) as String
        } ?? "Unknown"
        
        let dataRef = unsafeBitCast(layoutData, to: CFData.self)
        let keyboardLayout = unsafeBitCast(CFDataGetBytePtr(dataRef), to: UnsafePointer<UCKeyboardLayout>.self)
        
        var generatedCharacters = Set<UInt32>()
        
        for keyCode in UInt16(0)...UInt16(53) {
            let with_cmd = charactersWithModifiers(keyboardLayout: keyboardLayout, keyCode: keyCode, shift: false, cmd: true);
            let with_shift = charactersWithModifiers(keyboardLayout: keyboardLayout, keyCode: keyCode, shift: true, cmd: false);
            let with_cmd_and_shift = charactersWithModifiers(keyboardLayout: keyboardLayout, keyCode: keyCode, shift: true, cmd: true);
            
            if keyCode == 36 { // enter
                continue;
            }
            
            if with_cmd_and_shift == with_cmd {
                generatedCharacters.insert(with_cmd.value)
                if with_cmd.isASCII && with_cmd.description.uppercased() != with_cmd.description.lowercased() {
                    generatedCharacters.insert(with_cmd.description.uppercased().unicodeScalars.first!.value)
                } else {
                    generatedCharacters.insert(with_shift.value)
                }
            } else {
                generatedCharacters.insert(with_cmd.value)
                generatedCharacters.insert(with_cmd_and_shift.value)
                
            }
        }
        
        let canTypeFullASCII = asciiGraphicalRange.isSubset(of: generatedCharacters)
        let missingChars = asciiGraphicalRange.subtracting(generatedCharacters)
        let extraChars = generatedCharacters.subtracting(asciiGraphicalRange)
        
        if !canTypeFullASCII {
            print("\(inputSourceID)\t\(inputSourceName)\t\(missingChars.sorted().map { String(UnicodeScalar($0)!) }.joined())\t\(extraChars.sorted().map { String(UnicodeScalar($0)!) }.joined())")
            todo.append(inputSource);
        }
        
    }
    return todo
}

@main
struct testApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.commandsRemoved().commands{ CustomCommands() }
    }

  
    init() {
        var todo: [TISInputSource] = getNonASCIICapableInputSources();
        var to_disable: TISInputSource?;
        
        NSEvent.addLocalMonitorForEvents(matching: [.keyDown]) { event in
            
            let inputSource = TISCopyCurrentKeyboardInputSource().takeRetainedValue();

            guard let mainMenu = NSApplication.shared.mainMenu else {
                print("no menu")
                return event;
            }
            
            printDifferences(menu: mainMenu, inputSource: inputSource)
            
            if let d = to_disable {
                TISDisableInputSource(d);
                to_disable = nil;
            }
            
            while true {
                
                guard let inputSource = todo.popLast() else {
                    return event;
                }
                
                let inputSourceName = TISGetInputSourceProperty(inputSource, kTISPropertyLocalizedName).map {
                    unsafeBitCast($0, to: CFString.self) as String
                } ?? "Unknown"
                let inputSourceID = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID).map {
                    unsafeBitCast($0, to: CFString.self) as String
                } ?? "Unknown"
                
                var enabled = false;
                if let enabledRef = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceIsEnabled)  {
                    let enabledBool = Unmanaged<CFBoolean>.fromOpaque(enabledRef).takeUnretainedValue();
                    enabled = CFBooleanGetValue(enabledBool)
                }
                
                if !enabled {
                    var enableable = false;
                    if let enableableRef = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceIsEnableCapable)  {
                        let enableableRef = Unmanaged<CFBoolean>.fromOpaque(enableableRef).takeUnretainedValue();
                        enableable = CFBooleanGetValue(enableableRef)
                        
                    }
                    if !enableable {
                        print("Cannot enable \(inputSourceID) \(inputSourceName)");
                        continue;
                    }
                    TISEnableInputSource(inputSource);
                    to_disable = inputSource;
                }
                TISSelectInputSource(inputSource)
        
                return event
            }
        }
   
       
    }
}
