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
   
   install -D -m755 src/libalpm_octopi_utils.so ${pkgdir}/usr/lib/libalpm_octopi_utils.so
   install -D -m644 src/libalpm_octopi_utils.pc ${pkgdir}/usr/lib/pkgconfig/libalpm_octopi_utils.pc
   install -D -m644 src/alpm_octopi_utils.h ${pkgdir}/usr/include/alpm_octopi_utils.h   

}
