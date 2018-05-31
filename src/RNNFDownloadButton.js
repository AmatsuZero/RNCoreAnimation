import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const NFDownloadButton = requireNativeComponent("JZHNFDownloadButton", RNNFDownloadButton)
export default class RNNFDownloadButton extends PureComponent {
    static propTypes = {
        downloaded: PropTypes.bool,
        buttonBackgroundColor: PropTypes.string,
        initialColor: PropTypes.string,
        rippleColor: PropTypes.string,
        downloadColor: PropTypes.string,
        deviceColor: PropTypes.string,
        downloadPercent: PropTypes.number,
        downloadState: PropTypes.oneOf(["toDownload", "willDownload", "readyToDownload", "downloaded"]),
        onNewState: PropTypes.func
    }
    render() {
        return (<NFDownloadButton {...this.props}/>)
    }
}