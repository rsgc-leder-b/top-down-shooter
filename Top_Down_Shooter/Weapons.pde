class Weapons {
  int weapon = 1;
  int canShoot = 0;
  int fireRate = 0;
  int recoil = 0;
  boolean shot = false;
  boolean shoot = true;
  /*
  Weapon
   1  = Pistol
   2 = AR
   3 = Melee
   */
  void run() {

    if (recoil > 0) {
      recoil -= recoil/20;
      recoil -= 2;
    }
    if (weapon == 1) {
      canShoot = 0;
      fireRate = 0;
    }

    if (weapon == 2) {
      fireRate = 5;
      shot = false;
      if (canShoot > 0) {
        canShoot -= 1;
      }
    }

    if (weapon == 3) {
      fireRate = 10;
      if (canShoot > 0) {
        canShoot -= 1;
      }
    }
  }
}
