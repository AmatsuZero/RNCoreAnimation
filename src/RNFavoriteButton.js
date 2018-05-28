import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import { requireNativeComponent } from "react-native"

const FavoriteButton = requireNativeComponent("JZHFavoriteButton", RNFavoriteButton)
export default class RNFavoriteButton extends PureComponent {
    static propTypes = {
        image: PropTypes.string.isRequired,
        imageColorOn: PropTypes.string,
        imageColorOff: PropTypes.string,
        circleColor: PropTypes.string,
        lineColor: PropTypes.string,
        duration: PropTypes.string,
        onSelect: PropTypes.func,
        onDeselect: PropTypes.func
    }
    render() {
        return (<FavoriteButton {...this.props}/>)
    }
}
