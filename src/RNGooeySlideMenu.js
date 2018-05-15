import React, { PureComponent } from 'react'
import PropTypes from "prop-types"
import {
    requireNativeComponent,
    UIManager,
    findNodeHandle
} from "react-native"
const GooeySlideMenu = requireNativeComponent("JZHGooeySlideMenu", RNGooeySlideMenu)
export default class RNGooeySlideMenu extends PureComponent {
     static propTypes = {
         color: PropTypes.string,
         buttonSpace: PropTypes.number,
         menuBlankWidth: PropTypes.number,
         buttonHeight: PropTypes.number,
         menuClickBlock: PropTypes.func.isRequired,
         titles: PropTypes.arrayOf(PropTypes.string).isRequired
     }
     trigger() {
         UIManager.dispatchViewManagerCommand(
             findNodeHandle(this),
             UIManager.GooeySlideMenu.Commands.trigger,
             null
         )
     }
     render() {
         return (<GooeySlideMenu {...this.props}/>)
     }
}
