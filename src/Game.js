import Phaser from 'phaser'
import Boot from './Boot'
import MainMenu from './MainMenu'
import World from './World'
import Room from './Room'

const config = {
  type: Phaser.AUTO,
  width: 800,
  height: 600,
  physics: {
    default: 'arcade',
    arcade: {
      gravity: {y: 0},
      debug: false
    }
  },
  scene: [Boot, MainMenu, World, Room],
  //scene: {
  //  preload: preload,
  //  create: create,
  //  update: update
  //}
}

const game = new Phaser.Game(config)

//let platforms
//let player
//let cursors
//let stars
//let bombs
//let score = 0
//let scoreText
//let gameOver = false
//let boxes
//
//function preload() {
//  this.load.image('floor', 'bg.png')
//  this.load.image('player', 'player.png')
//  this.load.image('box', 'box.png')
//  //this.load.image('star', 'assets/star.png')
//  this.load.image('bomb', 'bomb.png')
//  //this.load.spritesheet('dude', 'assets/dude.png', {
//  //  frameWidth: 32, frameHeight: 48
//  //})
//}
//
//function create() {
//  this.add.image(384, 320, 'floor')
//
//  //platforms = this.physics.add.staticGroup()
//  //platforms.create(400, 568, 'ground').setScale(2).refreshBody()
//  //platforms.create(600, 400, 'ground')
//  //platforms.create(50, 250, 'ground')
//  //platforms.create(750, 220, 'ground')
//
//  player = this.physics.add.sprite(randomX(), randomY(),'player')
//  player.setScale(4)
//  ////this.add.image(400, 300, 'star')
//  //player = this.physics.add.sprite(100, 450, 'dude')
//  player.setBounce(1, 1)
//  player.setCollideWorldBounds(true)
//  //
//  boxes = this.physics.add.staticGroup()
//  for(let i = 0; i < 20; i++) {
//    boxes.create(randomX(), randomY(), 'box')
//  }
//  boxes.refresh()
//
//  //this.anims.create({
//  //  key: 'left',
//  //  frames: this.anims.generateFrameNumbers('dude', {
//  //    start: 0,
//  //    end: 3
//  //  }),
//  //  frameRate: 10,
//  //  repeat: -1
//  //})
//
//  //this.anims.create({
//  //  key: 'trun',
//  //  frames: [{key:'dude', frame: 4}],
//  //  frameRate: 20
//  //})
//
//  //this.anims.create({
//  //  key: 'right',
//  //  frames: this.anims.generateFrameNumbers('dude', {
//  //    start: 5,
//  //    end: 8
//  //  }),
//  //  frameRate: 10,
//  //  repeat: -1
//  //})
//
//  this.physics.add.collider(player, boxes)
//  this.physics.add.overlap(player, boxes, (player, box) => {
//    console.log(box)
//  })
//
//  cursors = this.input.keyboard.createCursorKeys()
//  //if(cursors.up.isDown && player.body.touching.down) {
//  //  player.setVelocityY(-330)
//  //}
//
//
//  //stars = this.physics.add.group({
//  //  key: 'star',
//  //  repeat: 11,
//  //  setXY: {x: 12, y: 0, stepX: 70}
//  //})
//  //stars.children.iterate(function(child) {
//  //  child.setBounceY(Phaser.Math.FloatBetween(0.4, 0.8))
//  //})
//
//  //this.physics.add.collider(stars, platforms)
//  //this.physics.add.overlap(player, stars, collectStar, null, this)
//
//
//  //scoreText = this.add.text(16, 16, 'score: 0', {fontSize: '32px', fill:'#000'})
//
//  //bombs = this.physics.add.group()
//  //this.physics.add.collider(bombs, platforms)
//  //this.physics.add.collider(player, bombs, hitBomb, null, this)
//}
//
//function randomX() {
//  return parseInt(Math.random() * 12) * 64 - 32
//}
//
//function randomY() {
//  return parseInt(Math.random() * 10) * 64 - 32
//}
//
//function update() {
//  if(cursors.left.isDown && player.x > 32) {
//    player.setX(player.x - 4)
//    //player.setVelocityX(-160)
//    //player.anims.play('left', true)
//  } else if (cursors.right.isDown && player.x < 768 - 32) {
//    player.setX(player.x + 4)
//    //player.setVelocityX(160)
//    //player.anims.play('right', true)
//  } else if (cursors.down.isDown && player.y < 640 - 32) {
//    player.setY(player.y + 4)
//    //player.setVelocityX(0)
//    //player.anims.play('turn')
//  } else if (cursors.up.isDown && player.y > 32) {
//    player.setY(player.y - 4)
//  } else if (cursors.space.isDown) {
//    this.add.sprite(player.x, player.y, 'bomb')
//  }
//
//}
//
export default game
