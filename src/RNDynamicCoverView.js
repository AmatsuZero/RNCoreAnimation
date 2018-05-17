import React, { PureComponent } from 'react'
import {
    requireNativeComponent,
    UIManager,
    findNodeHandle
} from "react-native"
const DynamicCover = requireNativeComponent("JZHDynamicCoverView", RNDynamicCoverView)

export default class RNDynamicCoverView extends PureComponent {
    restore() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHDynamicCoverView.Commands.restore,
            null
        )
    }
    render() {
        return (<DynamicCover {...this.props}/>)
    }
}
