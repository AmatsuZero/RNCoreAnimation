import React, { Component } from "react"
import { View } from "react-native"
import { RNAnimatedDownloadButton } from "rn-coreanimation"

export default class AnimatedDownloadButton extends Component {
    styles = {
       wrapper: {
           flex:1,
           justifyContent: 'center',
           alignItems: 'center',
           backgroundColor: '#ffd700'
       },
       button: {
           width: 100,
           height: 100,
           backgroundColor: '#007aff',
           borderRadius: 50
       }
    }
    render() {
        return (
            <View style={this.styles.wrapper}>
                <RNAnimatedDownloadButton
                    style={this.styles.button}
                    progressBarHeight={30}
                    progressBarWidth={200}/>
            </View>
        )
    }
}
