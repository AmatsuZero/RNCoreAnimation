import React, { Component } from "react"
import { View } from "react-native"
import { RNFavoriteButton } from "rn-coreanimation"

export default class FavoriteButton extends Component {
    styles = {
        container: {
            flex: 1,
            flexDirection: 'row',
            alignItems: 'center',
            justifyContent: 'space-between',
            alignSelf:"stretch"
        },
        item: {
            width: 44,
            height: 44
        }
    }
    render() {
        return <View style={this.styles.container}>
            <RNFavoriteButton image={"star"}
                              style={this.styles.item}/>
            <RNFavoriteButton image={"heart"}
                              imageColorOn={"#fe6e6f"}
                              circleColor={"#fe6e6f"}
                              lineColor={"#e26060"}
                              style={this.styles.item}
            />
            <RNFavoriteButton image={"Like"}
                              imageColorOn={"#3498db"}
                              circleColor={"#3498db"}
                              lineColor={"#2980b9"}
                              style={this.styles.item}
            />
            <RNFavoriteButton image={"smile"}
                              imageColorOn={"#2dcc70"}
                              circleColor={"#2dcc70"}
                              lineColor={"#2dc36a"}
                              style={this.styles.item}
            />
        </View>
    }
}
