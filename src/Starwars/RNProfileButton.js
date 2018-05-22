import React, { PureComponent } from "react"
import { requireNativeComponent } from "react-native"
import PropTypes from "prop-types"

const Button = requireNativeComponent("JZHProfileButtonView", RNProfileButton)
export default class RNProfileButton extends PureComponent {
    static propTypes = {
        clickEvent: PropTypes.func,
        title: PropTypes.string
    }
    static defaultProps = {
        title: "",
        clickEvent: null
    }
    render() {
        return <Button {...this.props}/>
    }
}
