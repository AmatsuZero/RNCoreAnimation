import React, { Component } from "react"
import {
    View
} from "react-native"
import { RNCardView } from "rn-coreanimation"

export default class extends Component {
    render() {
        return (
            <View style={{
                flex: 1,
                justifyContent: 'center',
                alignItems: 'center',
                backgroundColor: "#F5FCFF"
            }}>
                <RNCardView
                    style={{width: 150, height: 200}}
                    cardImageName={"poster"}
                    cardParallaxImageName={"posterBg"}/>
            </View>
        )
    }
}
