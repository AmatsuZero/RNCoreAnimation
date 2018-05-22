import React, { PureComponent } from "react"
import { requireNativeComponent } from "react-native"
import PropTypes from "prop-types"

const Background = requireNativeComponent("JZHStarOverlayView", RNStarOverlayView)
export default class RNStarOverlayView extends PureComponent {
    static propTypes = {
        emitImage: PropTypes.string.isRequired
    }
    render() {
        return <Background {...this.props}/>
    }
}
