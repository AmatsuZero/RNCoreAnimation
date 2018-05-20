import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const AnimatedText = requireNativeComponent("JZHAnimatedTextView", RNAnimatedTextView)
export default class RNAnimatedTextView extends PureComponent {
    static propTypes = {
        duration: PropTypes.number,
        fontName: PropTypes.string.isRequired,
        delayTime: PropTypes.number.isRequired,
        message: PropTypes.string.isRequired
    }
    static defaultProps = {
        duration: 5
    }
    render() {
        return (<AnimatedText {...this.props}/>)
    }
}
