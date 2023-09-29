# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..12} )
PYTHON_REQ_USE="threads(+)"

inherit bash-completion-r1 distutils-r1 multiprocessing

DESCRIPTION="Universal Command Line Environment for AWS"
HOMEPAGE="
	https://aws.amazon.com/cli/
	https://github.com/aws/aws-cli/
	https://pypi.org/project/awscli/"
SRC_URI="https://github.com/aws/aws-cli/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~riscv ~sparc ~x86"
IUSE="test doc"

RDEPEND="
	dev-python/awscrt[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml-clib[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	doc? (
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/sphinx[${PYTHON_USEDEP}]
	)
	!app-admin/awscli-bin"

BDEPEND="
	dev-python/flit-core[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest

S="${WORKDIR}/aws-cli-${PV}"

PATCHES=(
	"${FILESDIR}/0001-disabled-vendored-imports-fixes-for-urllib3.patch"
)

python_test() {
	local EPYTEST_DESELECT=(
		# broken xdist (signal() works only in main thread)
		tests/functional/ecs/test_execute_command.py::TestExecuteCommand::test_execute_command_success
		tests/unit/customizations/codeartifact/test_adapter_login.py::TestDotNetLogin::test_login_dotnet_sources_listed_with_backtracking
		tests/unit/customizations/codeartifact/test_adapter_login.py::TestDotNetLogin::test_login_dotnet_sources_listed_with_backtracking_windows
		tests/unit/customizations/codeartifact/test_adapter_login.py::TestNuGetLogin::test_login_nuget_sources_listed_with_backtracking
		tests/unit/customizations/ecs/test_executecommand_startsession.py::TestExecuteCommand::test_execute_command_success
		tests/unit/test_compat.py::TestIgnoreUserSignals
		tests/unit/test_help.py::TestHelpPager::test_can_handle_ctrl_c
		tests/unit/test_help.py::TestHelpPager::test_can_render_contents
		tests/unit/test_utils.py::TestIgnoreCtrlC::test_ctrl_c_is_ignore
	)
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	# integration tests require AWS credentials and Internet access
	epytest tests/{functional,unit} -p xdist -n "$(makeopts_jobs)"
}

python_install_all() {
	newbashcomp bin/aws_bash_completer aws

	insinto /usr/share/zsh/site-functions
	newins bin/aws_zsh_completer.sh _aws

	distutils-r1_python_install_all

	rm "${ED}"/usr/bin/{aws.cmd,aws_bash_completer,aws_zsh_completer.sh} || die
}
