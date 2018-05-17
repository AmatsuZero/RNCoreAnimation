import React, { Component } from "react"
import { View, Text, Button } from "react-native"
import { RNDynamicCoverView } from "rn-coreanimation"

export default class DynamicCoverDemo extends Component {
    styles = {
        wrapper: {
            flex: 1,
            justifyContent: 'center',
            alignItems: 'center',
            backgroundColor: '#c6e2ff'
        },
        cover: {
            flex: 1,
            justifyContent: 'center',
            alignItems: 'center',
            backgroundColor: '#3b5998',
            alignSelf: 'stretch'
        },
        text: {
            fontSize: 24,
            fontWeight: 'bold',
            color: "#800080"
        }
    }
    constructor(props) {
        super(props)
        this.coverRef = null
    }
    render() {
        return (
            <View style={this.styles.wrapper}>
                <RNDynamicCoverView
                    ref={ ref => this.coverRef=ref}
                    style={this.styles.cover}
                >
                    <Text style={this.styles.text}>Cover</Text>
                </RNDynamicCoverView>
                <Button
                    title={"Restore"}
                    onPress={() => this.coverRef.restore()}
                />
            </View>
        )
    }
}
