import React, { Component } from "react"
import { ImageBackground } from "react-native"
import { RNAnimatedText } from "rn-coreanimation"
const fontName = "MFTongXin_Noncommercial-Regular"
export default class extends Component {
    styles = {
        container:{
            flex: 1,
            justifyContent: 'center',
            alignItems: 'center'
        },
        text: {
            width: 300,
            height: 50,
            marginVertical: 10
        }
    }
    render() {
        return (
            <ImageBackground source={require("./bg.png")} style={this.styles.container}>
                <RNAnimatedText fontName={fontName} delayTime={5} message={"楚城今近远，"}
                                style={this.styles.text}/>
                <RNAnimatedText fontName={fontName} delayTime={10} message={"积霭寒塘暮。"}
                                style={this.styles.text}/>
                <RNAnimatedText fontName={fontName} delayTime={15} message={"水浅舟且迟，"}
                                style={this.styles.text}/>
                <RNAnimatedText fontName={fontName} delayTime={20} message={"淮潮至何处。"}
                                style={this.styles.text}/>
            </ImageBackground>
        )
    }
}
