import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import {
    requireNativeComponent,
    UIManager,
    findNodeHandle
} from "react-native"

const Drawingboard = requireNativeComponent("JZHDrawingboardView", RNDrawingboard)
export default class RNDrawingboard extends PureComponent {
    static propTypes = {
        color: PropTypes.string.isRequired
    }
    play() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHDrawingboardView.Commands.play,
            null
        )
    }
    undo() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHDrawingboardView.Commands.undo,
            null
        )
    }
    clear() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHDrawingboardView.Commands.clear,
            null
        )
    }
    capture() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHDrawingboardView.Commands.capture,
            null
        )
    }
    playDemo() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHDrawingboardView.Commands.playDemo,
            null
        )
    }
    render() {
        return <Drawingboard {...this.props}/>
    }
}
