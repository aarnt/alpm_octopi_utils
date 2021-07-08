pkgname=alpm_octopi_utils
pkgver=1.0.2
pkgrel=1
pkgdesc="Alpm utils for Octopi"
url="https://octopiproject.wordpress.com/"
arch=('i686' 'x86_64')
license=('GPL3')
depends=('pacman-contrib')
makedepends=('vala')
source=("git+https://github.com/aarnt/alpm_octopi_utils.git")
md5sums=('SKIP')
         
build() {
   cd ${pkgname}
   
   make
}

package() {
   cd ${pkgname}
   
   make DESTDIR=${pkgdir} install
}
