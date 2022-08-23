import Phaser from 'phaser'
export default class RoomList extends Phaser.Scene {
  constructor() {
    super('RoomList')
  }
  create() {
    this.add.image(400, 300, 'background').setScale(2)
  }
}
