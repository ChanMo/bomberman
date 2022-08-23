import Phaser from 'phaser'
export default class World extends Phaser.Scene {
  constructor() {
    super('World')
  }  
  preload() {
    this.load.image('water', 'assets/newtiles/water/2_water.png')
    this.load.image('world', 'assets/worlds/new_worldmap/Maanosa1_large.png')
    //this.load.image('option', 'assets/ui/options_button.png')
    
    // this.load.image('battle', 'assets/arena/battle_btn.png')
    // //this.load.image('info', 'assets/arena/info.png')
    // this.load.image('share', 'assets/arena/openbrowser.png')
    // this.load.image('chat', 'assets/arena/icon_chat.png')
    this.load.image('home_icon', 'assets/ui/buttons/button_home.png')
    this.load.image('user', 'assets/worlds/captain.png')
  }
  create() {
    this.add.image(400,300,'water').setScale(14,10)
    this.add.image(400, 300,'world')
    const homeButton = this.add.image(60,60,'home_icon').setOrigin(0.5).setScale(0.5)
    homeButton.setInteractive()
    homeButton.on('pointerdown', ()=>{
      this.scene.switch('MainMenu')
    })

    const user = this.add.image(400,300,'user').setScale(0.25)
    user.setInteractive()
    user.on('pointerdown', ()=>{
      this.scene.start('Room')
    })
    
    // this.add.image(960, 64, 'battle').setScale(0.25)
    // this.add.image(960, 144, 'chat').setScale(0.25)
    // this.add.image(960, 228, 'share').setScale(0.25)
    
    // this.input.once('pointerdown', () => {
    //   this.scene.start('Room')
    // })    
  }
}
