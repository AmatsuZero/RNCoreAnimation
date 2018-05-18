import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import {
    requireNativeComponent,
    UIManager,
    findNodeHandle
} from "react-native"

const PulseLoader = requireNativeComponent("JZHPulseLoaderView", RNPulseLoader)
export default class RNPulseLoader extends PureComponent {
    static propTypes = {
        fillColor: PropTypes.string.isRequired
    }
    start() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHPulseLoaderView.Commands.start,
            null
        )
    }
    render() {
        return <PulseLoader {...this.props}/>
    }
}
