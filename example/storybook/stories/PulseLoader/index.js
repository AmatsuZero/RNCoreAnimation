import React, { Component } from "react"
import { View } from "react-native"
import { RNPulseLoader } from "rn-coreanimation"

export default class extends Component {
    constructor(props) {
        super(props)
        this.starRef = null
    }
    render() {
        return (
            <View style={{
                flex: 1,
                justifyContent: 'center',
                alignItems: 'center',
                backgroundColor: "#F5FCFF"
            }}>
                <RNPulseLoader
                    ref={ref => this.starRef=ref}
                    fillColor={"#d60000"}
                    style={{width: 50, height: 50}}
                />
            </View>
        )
    }
}
