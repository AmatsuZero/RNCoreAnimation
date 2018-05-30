import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const NFDownloadButton = requireNativeComponent("JZHFavoriteButton", RNNFDownloadButton)
export default class RNNFDownloadButton extends PureComponent {
    static propTypes = {
        downloaded: PropTypes.bool,
        buttonBackgroundColor: PropTypes.string,
        initialColor: PropTypes.string,
        rippleColor: PropTypes.string,
        downloadColor: PropTypes.string,
        deviceColor: PropTypes.string,
        downloadPercent: PropTypes.number,
        downloadState: PropTypes.oneOf(["toDownload", "willDownload", "readyToDownload", "downloaded"])
    }
    render() {
        return (<NFDownloadButton {...this.props}/>)
    }
}