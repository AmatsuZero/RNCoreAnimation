import React from 'react';
import { Text } from 'react-native';

import { storiesOf } from '@storybook/react-native';
import { action } from '@storybook/addon-actions';
import { linkTo } from '@storybook/addon-links';
import { RNFireworkButton } from "rn-coreanimation"

import Button from './Button';
import CenterView from './CenterView';
import Welcome from './Welcome';

import CircleView from "./RNCircleView"
import DownloadButton from "./AnimatedDownloadButton"
import LoadingHUD from "./LoadingHUD"
import DynamicCover from "./DynamicCover"
import CardView from "./tvOSCardView"
import JumpStar from "./JumpStar"
import PulseLoader from "./PulseLoader"
import RNAnimatedText from "./AnimatedText"
import DrawingBoard from "./Drawingboard/index"

storiesOf('Welcome', module).add('to Storybook', () => <Welcome showApp={linkTo('Button')} />);

storiesOf('Button', module)
  .addDecorator(getStory => <CenterView>{getStory()}</CenterView>)
  .add('with text', () => (
    <Button onPress={action('clicked-text')}>
      <Text>Hello Button</Text>
    </Button>
  ))
  .add('with some emoji', () => (
    <Button onPress={action('clicked-emoji')}>
      <Text>😀 😎 👍 💯</Text>
    </Button>
  ))
  .add("Fireworks", () => <RNFireworkButton
      particleImageName={"Sparkle"}
      activeImageName={"Like-Blue"}
      inactiveImageName={"Like"}
      style={{width: 32, height: 30}}
  />);

storiesOf('Circle View', module)
    .add('Display', () => <CircleView/>)

storiesOf('Download Button', module)
    .add('Display', () => <DownloadButton/>)

storiesOf('Ball Loading HUD', module)
    .add('Display', () => <LoadingHUD/>)

storiesOf("Dynamic Cover", module)
    .add('Display', () => <DynamicCover/>)

storiesOf("tvOS Card View", module)
    .add('Native', () => <CardView/>)

storiesOf("Jump Star", module)
    .add('Native', () => <JumpStar/>)

storiesOf("Pulse loader", module)
    .add("Display", () => <PulseLoader/>)

storiesOf("Animated Text", module)
    .add("Poem Show", () => <RNAnimatedText/>)

storiesOf("Drawing Board", module)
    .add("Display", () => <DrawingBoard/>)
