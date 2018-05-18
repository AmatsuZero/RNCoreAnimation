import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import {
    requireNativeComponent,
    UIManager,
    findNodeHandle
} from "react-native"

const JumpStar = requireNativeComponent("JZHJumpStarView", RNJumpStar)
export default class RNJumpStar extends PureComponent {
    static propTypes = {
        mark: PropTypes.bool,
        topImage: PropTypes.string.isRequired,
        backImage: PropTypes.string.isRequired
    }
    static defaultProps = {
        mark: true
    }
    flip() {
        UIManager.dispatchViewManagerCommand(
            findNodeHandle(this),
            UIManager.JZHJumpStarView.Commands.flip,
            null
        )
    }
    render() {
        return (<JumpStar {...this.props}/>)
    }
}
