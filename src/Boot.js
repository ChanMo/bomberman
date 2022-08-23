import Phaser from 'phaser'

export default class Boot extends Phaser.Scene {
  constructor() {
    super('Boot')
  }
  preload() {
    this.load.bitmapFont('atari', 'atari-smooth.png', 'atari-smooth.xml')
  }
  create() {
    this.scene.start('MainMenu')
  }
}
