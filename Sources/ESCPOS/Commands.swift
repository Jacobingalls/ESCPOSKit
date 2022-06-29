//
//  Commands.swift
//  
//
//  Created by Jacob Ingalls on 6/1/22.
//

import Foundation

/// - See Also: https://www.epson-biz.com/modules/ref_escpos/index.php?cat_id=2
public enum ESCPOSCommand {
    
    // MARK: - Fallthrough Commands
    case raw(Data)
    case ascii(String)
    indirect case group([ESCPOSCommand])
    
    // MARK: - Print Commands
    
    /// LF
    /// Prints the data in the print buffer and feeds one line, based on the current line spacing.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=10
    case printAndLineFeed
    
    /// FF
    /// In Page mode, prints all the data in the print buffer collectively and switches from Page mode to Standard mode.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=12
    case printAndReturnToStandardModeInPageMode
    
    /// CR
    /// Executes one of the following operations.
    ///
    /// - When auto line feed is enabled
    ///     - Horizontal alignment: Executes printing and one line feed as LF
    ///     - Vertical alignment: Executes printing and one line feed as LF
    /// - When auto line feed is disabled
    ///     - Horizontal alignment: This command is ignored.
    ///     - Vertical alignment: In Standard mode, prints the data in the print buffer and moves the print position to the beginning of the print line. in Page mode, moves the print position to the beginning of the print line.
    ///
    /// Horizontal alignment:  is applied to Line thermal head or Shuttle head.
    ///
    /// Vertical alignment: is applied to Serial dot head.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=13
    case printAndCarriageReturn
    
    /// ESC FF
    /// In Page mode, prints the data in the print buffer collectively.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=14
    case printDataInPageMode
    
    /// ESC J
    /// Prints the data in the print buffer and feeds the paper [n × (vertical or horizontal motion unit)].
    ///  - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=15
    case printAndFeedPaper(byAmount: UInt8)
    
    /// ESC K
    /// Prints the data in the print buffer and feeds the paper n × (vertical or horizontal motion unit) in the reverse direction.
    ///  - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=16
    case printAndReverseFeedPaper(byAmount: UInt8)
    
    /// ESC d
    /// Prints the data in the print buffer and feeds n lines.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=17
    case printAndFeed(lines: UInt8)
    
    /// ESC e
    /// Prints the data in the print buffer and feeds n lines in the reverse direction.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=18
    case printAndReverseFeed(lines: UInt8)
    
    
    // MARK: - Line Spacing Commands
    
    /// ESC 2
    /// Sets the line spacing to the "default line spacing."
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=19
    case setLineSpacingToDefault
    
    /// ESC 3
    /// Sets the line spacing to n × (vertical or horizontal motion unit).
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=20
    case setLineSpacing(toAmount: UInt8)
    
    
    // MARK: - Character Commands
    
    /// CAN
    /// In Page mode, deletes all the print data in the current print area.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=21
    case cancelPrintDataInPageMode
    
    /// ESC SP
    /// Sets the right-side character spacing to n × (horizontal or vertical motion unit).
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=22
    case setRightSideCharacterSpacing(byAmount: UInt8 = 0)
    
    /// ESC !
    /// Selects the character font and styles (emphasized, double-height, double-width, and underline) together
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=23
    case selectPrintMode(PrintMode)
    
    /// ESC -
    /// Turns underline mode on or off
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=24
    case underline(UnderlineMode)
    
    /// ESC E
    /// Turns emphasized mode on or off.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=25
    case emphasize(Bool)
    
    /// ESC G
    /// Turns double-strike mode on or off.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=26
    case doubleStrike(Bool)
    
    /// ESC M
    /// Selects a character font
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=27
    case characterFont(CharacterFont)
    
    /// ESC R
    /// Selects an international character set
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=29
    case internationalCharacterSet(InternationalCharacterSet)
    
    /// ESC V
    /// In Standard mode, turns 90° clockwise rotation mode on or off for characters
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=30
    case clockwise90DegreeRotation(RotationMode)
    
    /// ESC r
    /// Selects a print color
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=31
    case printColor(PrintColor)
    
    /// ESC t
    /// Selects a page n from the character code table
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=32
    case characterCodeTable(CharacterCodeTable)
    
    /// ESC {
    /// In Standard mode, turns upside-down print mode
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=33
    case upsidedown(Bool)
    
    /// GS !
    /// Selects character size (height magnification and width magnification).
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=34
    case characterSize(vertical: FontSize, horizontal: FontSize)
    
    /// GS B
    /// Turns white/black reverse print mode on or off.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=35
    case inverseColors(Bool)
    
    /// GS b
    /// Turns smoothing mode on or off.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=36
    case fontSmoothing(Bool)
    
    // MARK: - Character Commands - Character effects
    
    /// GS ( N <Funciton 48>
    /// Selects character color
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=38
    case characterColor(CharacterColor)
    
    /// GS ( N <Funciton 49>
    /// Selects background color
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=39
    case backgroundColor(CharacterColor)
    
    /// GS ( N <Funciton 50>
    /// Turns the character shadow mode on or off.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=40
    case characterShadow(Bool, CharacterColor)
    
    
    // MARK: - Character Commands - User-defined characters
    
    /// ESC %
    /// Selects or cancels the user-defined character set.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=41
    case useUserDefineCharacterSet(Bool)
    
    // TODO: ESC &
    /// ESC &
    /// Defines the user-defined character pattern for the specified character codes.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=42
    // case defineUserDefinedCharacters(...)
    
    /// ESC ?
    /// Defines the user-defined character pattern for the specified character codes.
    /// - Note: Char must be 32 ≤ x ≤ 126
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=42
    case cancelUserDefinedCharacter(UInt8)
    
    // MARK: - Character Commands - Code conversion method
    // TODO: FS ( C <Function 48, 60>
    
    // MARK: - Printing Paper Commands - Label and black mark control
    // TODO: FS ( L <Function 33, 34, 48, 65, 66, 67, 80>
    
    // MARK: - Print Position Commands
    
    /// HT
    /// Moves the print position to the next horizontal tab position.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=52
    case horizontalTab
    
    /// ESC $
    /// Moves the print position to `amount` × (horizontal or vertical motion unit) from the left edge of the print area.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=54
    case setAbsolutePrintPosition(amountFromLeftEdge: UInt16)
    
    /// ESC D
    /// Sets horizontal tab positions.
    /// - Note: Maximum of 32 positions
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=53
    case setHorizontalTabPositions([UInt8])
    
    /// ESC T
    /// In Page mode, selects the print direction and starting position
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=55
    case selectPrintDirectionInPageMode(PrintDirection)
    
    /// ESC W
    /// In Page mode, sets the size and the logical origin of the print area
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=56
    case setPrintAreaInPageMode(x: UInt16, y: UInt16, width: UInt16, height: UInt16)
    
    /// ESC \
    /// Moves the print position `distance` × (horizontal or vertical motion unit) from the current position.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=57
    case setRelativePrintPosition(distanceFromCurrentPosition: Int16)
    
    /// ESC a
    /// In Standard mode, aligns all the data in one line to the selected layout
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=58
    case justification(Justification)
    
    /// GS $
    /// In Page mode, moves the vertical print position to `amount` × (vertical or horizontal motion unit) from the starting position set by ESC T.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=59
    case setAbsoluteVerticalPrintPositionInPageMode(amount: UInt16)
    
    /// GS L
    /// In Standard mode, sets the left margin to `amount`× (horizontal motion unit) from the left edge of the printable area.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=60
    case setLeftMargin(toAmount: UInt16)
    
    /// GS T
    /// In Standard mode, moves the print position to the beginning of the print line after performing the operation specified by n. n specifies the data processing in the print buffer when this command is executed.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=61
    case setPrintPositionToTheBeginningOfPrintLine(flushPrintBuffer: Bool)
    
    /// GS W
    /// In Standard mode, sets the print area width to `amount` × (horizontal motion unit).
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=62
    case setPrintAreaWidth(toAmount: UInt16)
    
    /// GS \
    /// In Page mode, moves the vertical print position to `distance` × (vertical or horizontal motion unit) from the current position.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=63
    case setRelativeVerticalPrintPositionInPageMode(distanceFromCurrentPosition: Int16)
    
    
    // MARK: - Paper Sensor Commands
    
    /// ESC c 3
    /// Selects the paper sensor(s) to output paper end signals when a paper end is detected
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=64
    case selectPaperSensorsToOutputPaperEndSignals(PaperEndSensors)
    
    /// ESC c 4
    /// Selects the paper sensor(s) to use to stop printing when a paper end is detected
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=65
    case selectPaperSensorsToStopPrinting(PaperEndSensors)
    
    
    // MARK: - Mechanism Control Commands
    
    /// ESC <
    /// Moves the print head to the standby position.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=66
    case returnHome
    
    /// ESC U
    /// Turns unidirectional print mode on or off.
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=67
    case unidirectionalPrintMode(Bool)
    
    // MARK: - Bit Image Commands
    
    /// GS ( L   <Function 50>
    /// Print the graphics data in the print buffer
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=98
    case printGraphicsBuffer
    
    // TODO: Support remaining functions
    
    /// GS ( L   /   GS 8 L   <Function 112> (Partial: Just monochrome, color 1)
    /// Store the graphics data in the print buffer (raster format)
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=99
    /// - Note: Will store as monochrome, color 1 version.
    case storeMonochromeRasterGraphicsDataInPrintBuffer(width: UInt16, height: UInt16, data: Data)
    
    
    public var dataValue: Data {
        switch self {
            
        // Fallthrough
        case .raw(let data):                                            return data
        case .ascii(let string):                                        return string.data(using: .ascii, allowLossyConversion: true)!
        case .group(let commands):                                      return commands.map(\.dataValue).reduce(Data(), +)
            
        // Print Commands
        case .printAndLineFeed:                                         return .init([ .LF ])
        case .printAndReturnToStandardModeInPageMode:                   return .init([ .FF ])
        case .printAndCarriageReturn:                                   return .init([ .CR ])
        case .printDataInPageMode:                                      return .init([ .ESC, .FF ])
        case .printAndFeedPaper(let amount):                            return .init([ .ESC, .J, amount ])
        case .printAndReverseFeedPaper(let amount):                     return .init([ .ESC, .K, amount ])
        case .printAndFeed(let lines):                                  return .init([ .ESC, .d, lines ])
        case .printAndReverseFeed(let lines):                           return .init([ .ESC, .e, lines ])
            
        // Line Spacing Commands
        case .setLineSpacingToDefault:                                  return .init([ .ESC, ._2 ])
        case .setLineSpacing(let amount):                               return .init([ .ESC, ._3, amount ])
        
        // Character Commands
        case .cancelPrintDataInPageMode:                                return .init([ .CAN ])
        case .setRightSideCharacterSpacing(let amount):                 return .init([ .ESC, .SP, amount ])
        case .selectPrintMode(let mode):                                return .init([ .ESC, .BANG, mode.rawValue ])
        case .underline(let mode):                                      return .init([ .ESC, .HYPH, mode.rawValue ])
        case .emphasize(let bool):                                      return .init([ .ESC, .E, (bool ? 1 : 0) ])
        case .doubleStrike(let bool):                                   return .init([ .ESC, .G, (bool ? 1 : 0) ])
        case .characterFont(let font):                                  return .init([ .ESC, .M, font.rawValue ])
        case .internationalCharacterSet(let set):                       return .init([ .ESC, .R, set.rawValue ])
        case .clockwise90DegreeRotation(let rotation):                  return .init([ .ESC, .V, rotation.rawValue ])
        case .printColor(let color):                                    return .init([ .ESC, .r, color.rawValue ])
        case .characterCodeTable(let table):                            return .init([ .ESC, .t, table.rawValue ])
        case .upsidedown(let bool):                                     return .init([ .ESC, .LBKT, (bool ? 1 : 0) ])
        case .characterSize(let vertical, let horizontal):              return .init([ .GS, .BANG, ( (vertical.rawValue << 4) | horizontal.rawValue ) ])
        case .inverseColors(let bool):                                  return .init([ .GS, .B, (bool ? 1 : 0) ])
        case .fontSmoothing(let bool):                                  return .init([ .GS, .b, (bool ? 1 : 0) ])
            
        // Character Commands - Character effects
        case .characterColor(let color):                                return .init([ .GS, .LPRN, .N, 0x02, 0x00, 0x30, color.rawValue ])
        case .backgroundColor(let color):                               return .init([ .GS, .LPRN, .N, 0x02, 0x00, 0x31, color.rawValue ])
        case .characterShadow(let bool, let color):                     return .init([ .GS, .LPRN, .N, 0x02, 0x00, 0x32, (bool ? 1 : 0), color.rawValue ])
            
        // Character Commands - User-defined characters
        case .useUserDefineCharacterSet(let bool):                      return .init([ .ESC, .PRCT, (bool ? 1 : 0) ])
        // TODO: ESC &
        case .cancelUserDefinedCharacter(let char):                     return .init([ .ESC, .QSMK, char ])
            
        // Character Commands - Code conversion method
        // TODO: FS ( C <Function 48, 60>
        
        // Printing Paper Commands - Label and black mark control
        // TODO: FS ( L <Function 33, 34, 48, 65, 66, 67, 80>
        
        // Print Position Commands
        case .horizontalTab:                                            return .init([ .HT ])
        case .setAbsolutePrintPosition(let amount):                     return .init([ .ESC, .DLLR, amount.low, amount.high ])
        case .setHorizontalTabPositions(let positions):                 return .init([ .ESC, .D] + positions.prefix(32) + [.NUL])
        case .selectPrintDirectionInPageMode(let dir):                  return .init([ .ESC, .T, dir.rawValue ])
        case .setPrintAreaInPageMode(let x, let y, let w, let h):       return .init([ .ESC, .W, x.low, x.high, y.low, y.high, w.low, w.high, h.low, h.high ])
        case .setRelativePrintPosition(let distance):                   let d = UInt16(distance); return .init([ .ESC, .BKSL, d.low, d.high ])
        case .justification(let justification):                         return .init([ .ESC, .a, justification.rawValue ])
        case .setAbsoluteVerticalPrintPositionInPageMode(let amount):   return .init([ .GS, .DLLR, amount.low, amount.high ])
        case .setLeftMargin(let amount):                                return .init([ .GS, .L, amount.low, amount.high ])
        case .setPrintPositionToTheBeginningOfPrintLine(let flush):     return .init([ .GS, .T, (flush ? 1 : 0) ])
        case .setPrintAreaWidth(let amount):                            return .init([ .GS, .W, amount.low, amount.high ])
        case .setRelativeVerticalPrintPositionInPageMode(let distance): let d = UInt16(distance); return .init([ .GS, .BKSL, d.low, d.high ])
            
        // Paper Sensor Commands
        case .selectPaperSensorsToOutputPaperEndSignals(let sensors):   return .init([ .ESC, .c, ._3, sensors.rawValue ])
        case .selectPaperSensorsToStopPrinting(let sensors):            return .init([ .ESC, .c, ._4, sensors.rawValue ])
            
        // Mechanism Control Commands
        case .returnHome:                                               return .init([ .ESC, .LT ])
        case .unidirectionalPrintMode(let bool):                        return .init([ .ESC, .U, (bool ? 1 : 0) ])
            
        // Bit Image Commands
        case .printGraphicsBuffer:                                      return .init([ .GS, .LPRN, .L, 0x02, 0x00, 0x30, 2 ])
        case .storeMonochromeRasterGraphicsDataInPrintBuffer(let w, let h, let d):
            let len = 10 + UInt16(d.count)
            return .init([ .GS, .LPRN, .L, len.low, len.high, 0x30, 0x70, 48, 1, 1, 49, w.low, w.high, h.low, h.high] + d)
        
        }
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=23
    public struct PrintMode: OptionSet {
        public let rawValue: UInt8
        
        public static let alternateFont         = PrintMode(rawValue: 1 << 0)
        public static let emphasized            = PrintMode(rawValue: 1 << 3)
        public static let doubleHeight          = PrintMode(rawValue: 1 << 4)
        public static let doubleWidth           = PrintMode(rawValue: 1 << 5)
        public static let underlined            = PrintMode(rawValue: 1 << 7)
        
        public static let `default`: PrintMode  = []
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=24
    public enum UnderlineMode: UInt8 {
        case off   = 0
        case thin  = 1
        case thick = 2
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=27
    public enum CharacterFont: UInt8 {
        case a = 0
        case b = 1
        case c = 2
        case d = 3
        case e = 4
        case specialA = 97
        case specialB = 98
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=29
    public enum InternationalCharacterSet: UInt8 {
        case unitedStates        = 0
        case france              = 1
        case germany             = 2
        case unitedKingdom       = 3
        case denmark1            = 4
        case sweden              = 5
        case italy               = 6
        case spain1              = 7
        case japan               = 8
        case norway              = 9
        case denmark2            = 10
        case spain2              = 11
        case latinAmerica        = 12
        case korea               = 13
        case sloveniaOrCroatia   = 14
        case china               = 15
        case vietnam             = 16
        case arabia              = 17
        case indiaDevanagari     = 66
        case indiaBengali        = 67
        case indiaTamil          = 68
        case indiaTelugu         = 69
        case indiaAssamese       = 70
        case indiaOriya          = 71
        case indiaKannada        = 72
        case indiaMalayalam      = 73
        case indiaGujarati       = 74
        case indiaPunjabi        = 75
        case indiaMarathi        = 82
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=30
    public enum RotationMode: UInt8 {
        case off           = 0
        case enabledNarrow = 1
        case enabledWide   = 2
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=31
    public enum PrintColor: UInt8 {
        case black = 0
        case red = 1
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=32
    public enum CharacterCodeTable: UInt8 {
        case pc437_USAAndStandardEurope         = 0
        case katakana                           = 1
        case pc850_Multilingual                 = 2
        case pc860_Portuguese                   = 3
        case pc863_CanadianFrench               = 4
        case pc865_Nordic                       = 5
        case hiragana                           = 6
        case onepassPrintingKanjiCharacters1    = 7
        case onepassPrintingKanjiCharacters2    = 8
        case pc851_Greek                        = 11
        case pc853_Turkish                      = 12
        case pc857_Turkish                      = 13
        case pc737_Greek                        = 14
        case iso8859_7_Greek                    = 15
        case wpc1252                            = 16
        case pc866_Cyrillic2                    = 17
        case pc852_Latin2                       = 18
        case pc858_Euro                         = 19
        case thai_CharacterCode_42              = 20
        case thai_CharacterCode_11              = 21
        case thai_CharacterCode_13              = 22
        case thai_CharacterCode_14              = 23
        case thai_CharacterCode_16              = 24
        case thai_CharacterCode_17              = 25
        case thai_CharacterCode_18              = 26
        case tcvn_3_Vietnamese1                 = 30
        case tcvn_3_Vietnamese2                 = 31
        case pc720_Arabic                       = 32
        case wpc775_BalticRim                   = 33
        case pc855_Cyrillic                     = 34
        case pc861_Icelandic                    = 35
        case pc862_Hebrew                       = 36
        case pc864_Arabic                       = 37
        case pc869_Greek                        = 38
        case iso8859_2_Latin2                   = 39
        case iso8859_15_Latin9                  = 40
        case pc1098_Farsi                       = 41
        case pc1118_Lithuanian                  = 42
        case pc1119_Lithuanian                  = 43
        case pc1125_Ukrainian                   = 44
        case wpc1250_Latin2                     = 45
        case wpc1251_Cyrillic                   = 46
        case wpc1253_Greek                      = 47
        case wpc1254_Turkish                    = 48
        case wpc1255_Hebrew                     = 49
        case wpc1256_Arabic                     = 50
        case wpc1257_BalticRim                  = 51
        case wpc1258_Vietnamese                 = 52
        case kz_1048_Kazakhstan                 = 53
        case devanagari                         = 66
        case bengali                            = 67
        case tamil                              = 68
        case telugu                             = 69
        case assamese                           = 70
        case oriya                              = 71
        case kannada                            = 72
        case malayalam                          = 73
        case gujarati                           = 74
        case punjabi                            = 75
        case marathi                            = 82
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=34
    public enum FontSize: UInt8 {
        case normal     = 0
        case double     = 1
        case triple     = 2
        case quadruple  = 3
        case quintuple  = 4
        case sextuple   = 5
        case septuple   = 6
        case octuple    = 7
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=38
    public enum CharacterColor: UInt8 {
        case none       = 48
        case color1     = 49
        case color2     = 50
        case color3     = 51
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=55
    public enum PrintDirection: UInt8 {
        case leftToRight = 0
        case bottomToTop = 1
        case rightToLeft = 2
        case topToBottom = 3
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=58
    public enum Justification: UInt8 {
        case left   = 0
        case center = 1
        case right  = 2
    }
    
    /// - Note: https://www.epson-biz.com/modules/ref_escpos/index.php?content_id=64
    public struct PaperEndSensors: OptionSet {
        public var rawValue: UInt8
        
        public static let nearEndSensor1 = PaperEndSensors(rawValue: 1 << 0)
        public static let nearEndSensor2 = PaperEndSensors(rawValue: 1 << 1)
        public static let endSensor1 = PaperEndSensors(rawValue: 1 << 2)
        public static let endSensor2 = PaperEndSensors(rawValue: 1 << 3)
        
        public static let none: PaperEndSensors = []
        public static let all: PaperEndSensors  = [ .nearEndSensor1, .nearEndSensor2, .endSensor1, .endSensor2 ]
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
}

fileprivate extension UInt8 {
    static let NUL:  Self = 0x00
    static let HT:   Self = 0x09
    static let LF:   Self = 0x0A
    static let FF:   Self = 0x0C
    static let CR:   Self = 0x0D
    static let CAN:  Self = 0x18
    static let ESC:  Self = 0x1B
    static let FS:   Self = 0x1C
    static let GS:   Self = 0x1D
    static let SP:   Self = 0x20
    static let BANG: Self = 0x21 // !
    static let DLLR: Self = 0x24 // $
    static let PRCT: Self = 0x25 // %
    static let LPRN: Self = 0x28 // (
    static let HYPH: Self = 0x2D // -
    static let _2:   Self = 0x32
    static let _3:   Self = 0x33
    static let _4:   Self = 0x34
    static let LT:   Self = 0x3C // <
    static let QSMK: Self = 0x3F // ?
    static let B:    Self = 0x42
    static let D:    Self = 0x44
    static let E:    Self = 0x45
    static let G:    Self = 0x47
    static let J:    Self = 0x4A
    static let K:    Self = 0x4B
    static let L:    Self = 0x4C
    static let M:    Self = 0x4D
    static let N:    Self = 0x4E
    static let R:    Self = 0x52
    static let T:    Self = 0x54
    static let U:    Self = 0x55
    static let V:    Self = 0x56
    static let W:    Self = 0x57
    static let BKSL: Self = 0x5C // \
    static let a:    Self = 0x61
    static let b:    Self = 0x62
    static let c:    Self = 0x63
    static let d:    Self = 0x64
    static let e:    Self = 0x65
    static let k:    Self = 0x6B
    static let r:    Self = 0x72
    static let t:    Self = 0x74
    static let LBKT: Self = 0x7B // {
}

fileprivate extension UInt16 {
    var low: UInt8 {
        return UInt8(self & 0xFF)
    }
    
    var high: UInt8 {
        return UInt8((self >> 8) & 0xFF)
    }
}

fileprivate extension UInt32 {
    var low: UInt16 {
        return UInt16(self & 0xFFFF)
    }
    
    var high: UInt16 {
        return UInt16((self >> 16) & 0xFFFF)
    }
}
