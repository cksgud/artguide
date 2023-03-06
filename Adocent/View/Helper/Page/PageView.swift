/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @Binding var onDemandPage: Int
    @Binding var direction: UIPageViewController.NavigationDirection
    var enableSwipe : Bool

    var body: some View {
        ZStack(alignment: .top) {
            PageViewController(pages: pages, currentPage: $onDemandPage, direction: $direction, enableSwipe: enableSwipe)
            PageControl(numberOfPages: pages.count, currentPage: $onDemandPage)
                .frame(width: CGFloat(pages.count * 18))
                .padding(.trailing)
                .hidden()
        }
    }
}

//struct PageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
//            .aspectRatio(3 / 2, contentMode: .fit)
//    }
//}
