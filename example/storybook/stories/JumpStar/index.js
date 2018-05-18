import React, { Component } from "react"
import {
    View,
    Button
} from "react-native"
import { RNJumpStar } from "rn-coreanimation"

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
                <RNJumpStar
                    ref={ref => this.starRef=ref}
                    mark={true}
                    topImage={"icon_star_incell"}
                    backImage={"blue_dot"}
                    style={{width: 19, height: 19}}/>
                <Button
                    style={{
                        fontSize: 15,
                        color: '#044aea'
                    }}
                    onPress={() => this.starRef.flip()}
                    title={"Jump!"}
                />
            </View>
        )
    }
}
