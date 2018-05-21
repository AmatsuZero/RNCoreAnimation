import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import {
    requireNativeComponent
} from "react-native"

const PulseLoader = requireNativeComponent("JZHPulseLoaderView", RNPulseLoader)
export default class RNPulseLoader extends PureComponent {
    static propTypes = {
        fillColor: PropTypes.string.isRequired
    }
    render() {
        return <PulseLoader {...this.props}/>
    }
}
