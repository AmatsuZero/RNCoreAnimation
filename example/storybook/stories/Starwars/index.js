import React, { PureComponent } from "react"
import {
    Image,
    Text,
    View,
    PixelRatio
} from "react-native"
import { RNStarOverlay, RNProfileButton } from "rn-coreanimation"

export default class Starwars extends PureComponent {
    styles = {
        container: {
            flex: 1,
            backgroundColor: "#000000",
            justifyContent: 'center',
            alignItems: 'center'
        },
        logo:{
            width: 250,
            height: 107
        },
        text: {
            fontSize: 19,
            color: '#ffffff',
            textAlign:'center',
            fontFamily:'Gotham Pro'
        },
        button: {
            borderRadius: 27,
            width: 193,
            height:54,
            borderWidth: 1,
            borderColor: "rgb(255,232,31)",
            marginTop: 43,
            alignItems:'center',
            justifyContent:'center'
        }
    }
    render() {
        return <RNStarOverlay style={this.styles.container} emitImage={"spark"}>
            <Image source={require('./star_wars_logo.png')} style={this.styles.logo}/>
            <View style={{marginTop: PixelRatio.get()*133/2}}>
                <Text style={this.styles.text}>GREETINGS,</Text>
                <Text style={[this.styles.text, {marginTop: 8}]}>MY YOUNG PADAWAN!</Text>
            </View>
            <RNProfileButton style={this.styles.button}>
                <Text style={[this.styles.text, {fontSize: 16}]}>Setup your profile</Text>
            </RNProfileButton>
        </RNStarOverlay>
    }
}
