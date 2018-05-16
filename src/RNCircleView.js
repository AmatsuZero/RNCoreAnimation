import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const CircleView = requireNativeComponent("JZHCircleView", RNCircleView)
export default class RNCircleView extends PureComponent {
    static propTypes = {
        progress: PropTypes.number
    }
    static defaultProps = {
        progress: 0.5
    }
    render() {
        return (<CircleView {...this.props}/>)
    }
}
