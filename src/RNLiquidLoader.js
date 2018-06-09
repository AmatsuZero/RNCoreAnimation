import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import {
    requireNativeComponent,
    UIManager,
    findNodeHandle
} from "react-native"

const LiquidLoader = requireNativeComponent("JZHLiquidLoaderView", RNLiquidLoader)

class LiquidLoaderEffect {
    constructor(info) {
        this.color = info["color"]
        this.count = info["count"]
        this.duration = info["duration"]
        this.growColor = info["growColor"]
        this.type = info["type"]
    }
}

export default class RNLiquidLoader extends PureComponent {
    static propTypes = {
        effect: PropTypes.instanceOf(LiquidLoaderEffect)
    }
    static defaultProps = {
        effect: new LiquidLoaderEffect({
            type: "circle",
            color: "#ffffff",
            count: 5,
            duration: 3.0,
            growColor: "#ff0000"
        })
    }
    show() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHLiquidLoaderView.Commands.show,
            null
        )
    }
    hide() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHLiquidLoaderView.Commands.hide,
            null
        )
    }
    render() {
        return (<LiquidLoader {...this.props}/>)
    }
}