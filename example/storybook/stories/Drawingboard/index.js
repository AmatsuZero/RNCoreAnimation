import React, { Component } from "react"
import {
    View
} from "react-native"
import { RNDrawingboard } from "rn-coreanimation"
import Pallet from "./panel"
const colors = [
    "#ff0000",
    "#ccac00",
    "#00283f",
    "#ff7373",
    "#01a1ff",
    "#e65dc3"]
export default class DrawingBoard extends Component {
    styles = {
        container: {
            flex: 1,
            justifyContent:'center',
            alignItems: 'center',
        },
        board: {
            flex: 3,
            backgroundColor: '#ffffff',
            alignSelf: 'stretch'
        },
        panel: {
            flex: 1,
            backgroundColor: '#8b9dc3',
            alignSelf: 'stretch'
        }
    }

    constructor(props) {
        super(props)
        this.state = {
            color: '#013456'
        }
        this.boardRef = null
    }

    render() {
        return (
            <View style={this.styles.container}>
                <RNDrawingboard color={this.state.color}
                                style={this.styles.board}
                                ref={ref =>this.boardRef=ref}
                />
                <Pallet dataSource={colors}
                        onSelect={index => this.setState({color: colors[index]})}
                        style={this.styles.panel}/>
            </View>
        )
    }
}
