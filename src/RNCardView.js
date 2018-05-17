import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const CardView = requireNativeComponent("JZHCardView")
export default class RNCardView extends PureComponent {
    static propTypes = {
        cardImageName: PropTypes.string.isRequired,
        cardParallaxImageName: PropTypes.string.isRequired
    }
    render() {
        return <CardView {...this.props}/>
    }
}
