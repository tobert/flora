# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#EGIT_REPO_URI="git://github.com/omniti-labs/reconnoiter.git"
EGIT_REPO_URI="git://github.com/tobert/reconnoiter.git"
EAPI=4

inherit eutils git

DESCRIPTION="Reconnoiter's goal is to better the world of monitoring by marrying fault detection and trending together."
HOMEPAGE="https://labs.omniti.com/labs/reconnoiter"
SRC_URI="ftp://foo.bar.com/${P}.tar.gz"

SRC_URI=""
KEYWORDS="~amd64 ~x86"
LICENSE=""
SLOT="0"
IUSE=""
RESTRICT="strip"

DEPEND="\
	sys-libs/zlib \
	sys-libs/ncurses \
	dev-libs/ossp-uuid \
	dev-libs/libpcre \
	dev-libs/openssl \
	dev-libs/libxslt \
	dev-libs/apr \
	dev-libs/apr-util \
	dev-lang/python \
	net-libs/libssh2 \
	dev-db/postgresql-base \
	net-analyzer/net-snmp \
	dev-java/sun-jdk"
RDEPEND="${DEPEND}"

src_configure() {
	autoreconf
	econf --with-java-libdir=/usr/share/reconnoiter \
	--sysconfdir=/etc/reconnoiter
}

#src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# This is the preferred way to install.
	#emake DESTDIR="${D}" install || die

	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall || die
#}
