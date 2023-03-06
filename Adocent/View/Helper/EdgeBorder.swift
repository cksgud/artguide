//
//  EdgeBorder.swift
//  Adocent
//
//  Created by 김찬형 on 2022/10/23.
//

import SwiftUI

struct EdgeBorder: Shape {
    var isSelected: Bool
    var tabOrder: TabOrder
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        for edge in edges {
            switch tabOrder {
            case .firstTab:
                var x: CGFloat {
                    switch edge {
                    case .top, .bottom, .leading: return getCustomizedScreenWidth(-65)
                    case .trailing: return rect.maxX - width
                    }
                }

                var y: CGFloat {
                    switch edge {
                    case .top, .leading, .trailing: return rect.minY
                    case .bottom: return rect.maxY - width
                    }
                }

                var w: CGFloat {
                    switch edge {
                    case .top, .bottom: return getCustomizedScreenWidth(165)
                    case .leading, .trailing: return self.width
                    }
                }

                var h: CGFloat {
                    switch edge {
                    case .top, .bottom: return isSelected ? getCustomizedScreenWidth(2) : getCustomizedScreenWidth(1)
                    case .leading, .trailing: return rect.height
                    }
                }
                path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
                
            case .secondTab:
                var x: CGFloat {
                    switch edge {
                    case .top, .bottom, .leading: return getCustomizedScreenWidth(-47)
                    case .trailing: return rect.maxX - width
                    }
                }

                var y: CGFloat {
                    switch edge {
                    case .top, .leading, .trailing: return rect.minY
                    case .bottom: return rect.maxY - width
                    }
                }

                var w: CGFloat {
                    switch edge {
                    case .top, .bottom: return getCustomizedScreenWidth(160)
                    case .leading, .trailing: return self.width
                    }
                }

                var h: CGFloat {
                    switch edge {
                    case .top, .bottom: return isSelected ? getCustomizedScreenWidth(2) : getCustomizedScreenWidth(1)
                    case .leading, .trailing: return rect.height
                    }
                }
                path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
            }
        }
        return path
    }
}
