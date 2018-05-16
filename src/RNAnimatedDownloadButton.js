import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const DownloadButton = requireNativeComponent("JZHDownloadButtonView", RNAnimatedDownloadButton)

export default class RNAnimatedDownloadButton extends PureComponent {
    static propTypes = {
        progressBarHeight: PropTypes.number.isRequired,
        progressBarWidth: PropTypes.number.isRequired
    }
    render() {
        return (<DownloadButton {...this.props}/>)
    }
}
