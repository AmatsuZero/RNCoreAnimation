import React, { PureComponent } from 'react'
import {
    View,
    Button
} from "react-native"
import { RNBallLoadingHUD } from "rn-coreanimation"

export default class LoadingHUD extends PureComponent {
    render() {
        return (
            <View style={{
                flex: 1,
                justifyContent: 'center',
                alignItems: 'center',
                backgroundColor: '#F5FCFF'
            }}>
                <Button title={"Click"}
                        onPress={ () => {
                            RNBallLoadingHUD.showHUD()
                            setTimeout(() => RNBallLoadingHUD.dismissHUD(), 3000)
                            }
                        }
                        color={"#841584"}
                />
            </View>
        )
    }
}
