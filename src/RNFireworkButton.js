import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const FireworkButton = requireNativeComponent("JZHFireworkButton", RNFireworkButton)

export default class RNFireworkButton extends PureComponent {
    static propTypes = {
        particleImageName: PropTypes.string.isRequired,
        particleScale: PropTypes.number,
        particleScaleRange: PropTypes.number,
        activeImageName: PropTypes.string.isRequired,
        inactiveImageName: PropTypes.string,
        activeCallback: PropTypes.func,
        disactiveCallback: PropTypes.func
    }
    static defaultProps = {
        particleScale: 0.05,
        particleScaleRange: 0.02
    }
    render() {
        return <FireworkButton {...this.props}/>
    }
}
