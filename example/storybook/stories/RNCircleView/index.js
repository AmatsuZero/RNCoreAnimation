import React, { Component } from "react"
import {
    View,
    Slider,
    Text
} from "react-native"
import { RNCircleView } from "rn-coreanimation"

export default class CircleView extends Component {
    styles ={
        container: {
            flex: 1,
            justifyContent:'center',
            alignItems: 'center'
        },
        circle: {
            width: 320,
            height: 320
        },
        slider: {
            marginTop: 20,
            height: 10,
            width: 320
        },
        text: {
            marginTop: 10,
            textAlign: 'center',
            fontSize: 17
        }
    }

    constructor(props) {
        super(props)
        this.state = {
            progress: 0.5
        }
    }

    render() {
        return (
            <View style={this.styles.container}>
                <RNCircleView
                    progress={this.state.progress}
                    style={this.styles.circle}
                />
                <Text style={this.styles.text}>
                    Current Value: {this.state.progress}
                </Text>
                <Slider
                    onValueChange={progress => this.setState({progress})}
                    style={this.styles.slider}
                    value={this.state.progress}
                    maximumValue={1}
                />
            </View>
        )
    }
}
