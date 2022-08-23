import Phaser from 'phaser'
export default class MainMenu extends Phaser.Scene {
  constructor() {
    super({
      key: 'MainMenu',
      pack: {
	files: [
	  { type: 'scenePlugin', key: 'SpinePlugin', url: 'plugins/3.8.95/SpinePluginDebug.js', sceneKey: 'spine' }
	]
      }
    })

  }
  // pack() {
  //   return {

  //   }
  // }  
  preload() {
    this.load.image('background', 'assets/bg/bg_desert.png')
    this.load.image('option', 'assets/ui/options_button.png')
    this.load.spine('set1', 'spine/3.8/demos/demos.json', ['spine/3.8/demos/atlas1.atlas'], true)

    this.load.image('shop', 'assets/arena/Shop_kokeiluikoni.png')
    this.load.image('battle', 'assets/arena/battle_icon.png')

  }

  create() {
    this.add.image(400,300, 'background').setScale(1.2)
    this.add.image(60,60, 'option').setScale(0.5)
    this.add.bitmapText(100,60,'atari', 'ChanMo', 24).setOrigin(0, 0.5)
    //this.add.bitmapText(400, 250, 'atari', 'PAOPAOTANG', 48).setOrigin(0.5)
    const boy = this.add.spine(200,500,'set1.spineboy', 'walk',true).setScale(0.5)

    const shopBox = this.add.container(720,40)
    const shopIcon = this.add.image(20,20, 'shop').setOrigin(0.5).setScale(0.25)
    const shopText = this.add.bitmapText(20,65,'atari','Shop',16).setOrigin(0.5)
    shopBox.add(shopIcon)
    shopBox.add(shopText)

    const battleBox = this.add.container(720,160)
    const battleIcon = this.add.image(20,20, 'battle').setOrigin(0.5).setScale(0.25)
    const battleText = this.add.bitmapText(20,65,'atari','Battle',16).setOrigin(0.5)
    battleBox.add(battleIcon)
    battleBox.add(battleText)

    battleBox.setSize(80,80)
    battleBox.setInteractive()
    battleBox.on('pointerdown', () => {
      this.scene.start('World')
    })
    
    // this.input.once('pointerdown', () => {
    //   this.scene.start('World')
    // })
    //this.scene.start('World')    
  }
}
