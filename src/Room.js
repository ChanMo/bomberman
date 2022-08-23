import Phaser from 'phaser'

export default class Room extends Phaser.Scene {
  player = null
  boxes = null
  cursors
  germ
  germ2
  germs
  bombs

  constructor() {
    super('Room')
  }

  preload() {
    //this.load.image('floor', 'bg.png')
    this.load.tilemapTiledJSON('map', 'room1.json')
    //this.load.tilemapTiledJSON('map', 'assets/mapfilesworld7/301.json')
    //this.load.tilemapTiledJSON('map', 'maps/level-with-coin-objects.json')
    this.load.image('Floor', 'assets/newtiles/floor/1_floor.png')
    this.load.image('Wall', 'assets/newtiles/stonebatch/1_stonebatch.png')
    this.load.image('Box', 'assets/newtiles/stonebatch/6_stonebatch.png')
    this.load.image('Door1', 'assets/tiles/sp/dooropen.png')
    this.load.image('room_bg', 'assets/bg/bg_beach.png')
    this.load.image('pause_icon', 'assets/ui/pause_button.png')
    
    
    //this.load.image('player', 'player.png')
    this.load.atlas('player', 'player.png', 'player.json')
    this.load.image('box', 'box.png')
    // this.load.image('bomb', 'bomb.png')
    //this.load.atlas('bomb', 'bomb.png', 'bomb.json')
    this.load.image('bomb', 'assets/levels/ar_bomb.png')
    this.load.atlas('germs', 'germs.png', 'germs.json')

  }
  create() {


    this.anims.create({
      key: 'idle',
      frames: this.anims.generateFrameNames('player', {prefix:'idle',start:1, end:2}),
      frameRate: 8,
      repeat: -1,
    })
    this.anims.create({
      key: 'left',
      frames: this.anims.generateFrameNames('player', {prefix:'left',start:1,end:4}),
      frameRate: 8,
      repeat: -1
    })
    this.anims.create({
      key: 'right',
      frames: this.anims.generateFrameNames('player', {prefix:'right',start:1,end:4}),
      frameRate: 8,
      repeat: -1
    })    
    // this.anims.create({
    //   key: 'bomb',
    //   frames: this.anims.generateFrameNames('bomb'),
    //   frameRate: 8,
    //   repeat: -1
    // })
    this.anims.create({
      key: 'germ1',
      frames: this.anims.generateFrameNames('germs', {prefix: 'red', start: 1, end: 3}),
      frameRate: 8,
      repeat: -1
    })
    this.anims.create({
      key: 'germ2',
      frames: this.anims.generateFrameNames('germs', {prefix: 'green', start: 1, end: 3}),
      frameRate: 8,
      repeat: -1
    })


    //const roomBox = this.add.container(400,300)
    
    this.add.image(400,300,'room_bg').setOrigin(0.5).setScale(1, 1.2)

    const pauseButton = this.add.image(60,60,'pause_icon').setOrigin(0.5).setScale(0.5)
    pauseButton.setInteractive()
    pauseButton.on('pointerdown', ()=>{
      this.scene.switch('MainMenu')
    })    
    
    this.physics.world.setBoundsCollision(true, true, true, true)

    var map = this.add.tilemap('map')
    map.createLayer('Tile Layer 1', [
      map.addTilesetImage('Floor'),
      //map.addTilesetImage('Door1'),
    ]).setPosition(100,100).setScale(0.65)
    const wallLayer = map.createLayer('Tile Layer 2', [
      map.addTilesetImage('Wall'),
      map.addTilesetImage('Box')
    ]).setScale(0.65).setPosition(100,100).setOrigin(0.5)
    
    this.bombs = this.physics.add.staticGroup()
    this.boxes = this.physics.add.staticGroup()
    //this.boxes = map.createLayer('Box Layer', map.addTilesetImage('Box1'))
    this.player = this.physics.add.sprite(100+64,100+128).setScale(0.7).setOrigin(0.5).play('idle').setCollideWorldBounds(true)
    
    map.setCollision([5,6,7,8,9,10])
    this.physics.add.collider(this.player, this.boxes)
    this.physics.add.collider(this.player, wallLayer)


    // germs
    this.germs = this.physics.add.group()
    this.physics.add.collider(this.germs, this.boxes)
    this.physics.add.collider(this.player, this.germs, this.gameOver, null, this)
    this.physics.add.collider(this.germs, wallLayer)    

    this.germs.create(384,384).play('germ1').setScale(1.2).setBounce(1,1).setCollideWorldBounds(true).setVelocity(0,100)
    this.germs.create(384,640).play('germ2').setScale(1.2).setBounce(1,1).setCollideWorldBounds(true).setVelocity(100, 0)

    //this.germs.create(128,128)

    // const pauseBox = this.add.container()
    // const pauseString = this.add.bitmapText(0,0,'atari', 'Paused',32)
    // pauseBox.add(pauseString)
    // pauseBox.setPosition(400,300)

    
    this.cursors = this.input.keyboard.createCursorKeys()
    
    this.physics.add.collider(this.player, this.bombs)
    this.physics.add.collider(this.boxes, this.bombs,(target, boxes)=>{console.log(target,boxes);target.destroy()},null,this)
    this.physics.add.collider(this.germs, this.bombs,(germ, target)=>{germ.destroy();this.win();},null,this)
    
    this.cursors.space.on('down', () => {
      //const bomb = this.bombs.create(this.player.x,this.player.y).play('bomb').setScale(3)
      const bomb = this.bombs.create(this.player.x,this.player.y, 'bomb').setScale(0.2)
      //this.physics.add.collider(this.player, bomb)
      // this.tweens.add({
      // 	targets: bomb,
      // 	delay: 3000,
      // 	onStart: (targets) => {
      // 	  console.log('start')
      // 	  targets.setScale(3.5)
      // 	},
      // 	onComplete: (targets) => {
      // 	  //bomb.setScale(5)
      // 	  //targets.destroy()
      // 	  console.log('done')
      // 	}
      // })
      this.time.delayedCall(
	3000,
	() => this.explode(bomb)
      )
      
    })

  }

  /** Bomb explode **/
  explode(target) {
    // destroy around things
    // this.physics.add.collider(
    //   this.player,
    //   target,
    //   this.gameOver,
    //   null,
    //   this
    // )

    target.setScale(0.25)    
    this.time.delayedCall(500, () => {
      target.destroy()      
    })
  }

  update() {
    
    if(this.cursors.left.isDown) {
      this.player.setVelocityX(-160)
      this.player.anims.play('left', true)
    } else if (this.cursors.right.isDown) {
      this.player.setVelocityX(160)
      this.player.anims.play('right', true)
    } else if (this.cursors.down.isDown) {
      this.player.setVelocityY(160)
      this.player.anims.play('idle', true)      
    } else if (this.cursors.up.isDown) {
      this.player.setVelocityY(-160)
      this.player.anims.play('idle', true)            
    } else if (this.cursors.left.isUp) {
      this.player.setVelocityX(0)
      this.player.setVelocityY(0)
      this.player.anims.play('idle', true)
    } else if (this.cursors.right.isUp) {
      this.player.setVelocityX(0)
    } else if (this.cursors.up.isUp) {
      this.player.setVelocityY(0)
    } else if (this.cursors.down.isUp) {
      this.player.setVelocityY(0)      
    }
  }

  win() {
    this.add.bitmapText(384, 320, 'atari', 'You Win !').setOrigin(0.5)
    this.input.keyboard.once('keydown-SPACE', () => {
      this.scene.start('MainMenu')
    }, this)
    this.input.once('pointerdown', () => {
      this.scene.start('MainMenu')
    }, this)
  }
  
  gameOver() {
    this.germs.setVelocity(0,0)
    //this.germ2.setVelocity(0,0)

    this.add.bitmapText(400, 300, 'atari', 'Game Over !').setOrigin(0.5).setCenterAlign()

    this.input.keyboard.once('keydown-SPACE', () => {
      this.scene.start('MainMenu')
    }, this)
    this.input.once('pointerdown', () => {
      this.scene.start('MainMenu')
    }, this)
  }
}

function randomX() {
  return parseInt(Math.random() * 12) * 64 - 32
}

function randomY() {
  return parseInt(Math.random() * 10) * 64 - 32
}
