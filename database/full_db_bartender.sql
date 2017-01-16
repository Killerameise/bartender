-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 17. Jan 2017 um 00:26
-- Server Version: 5.6.20
-- PHP-Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `bartender`
--
CREATE DATABASE IF NOT EXISTS `bartender` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `bartender`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cocktails`
--

CREATE TABLE IF NOT EXISTS `cocktails` (
  `name` varchar(150) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `cocktails`
--

INSERT INTO `cocktails` (`name`, `description`) VALUES
('Kotzer', 'der ist eklig!!!!'),
('Mojito', 'Der authentische kubanische Mojito: Das ist Energie und Leidenschaft, die direkt aus Havanna zu dir kommt. Drei Regeln für maximalen Genuss:\r\n\r\nHavana Club Añejo 3 Años, in Kuba hergestellt und gealtert, für authentischen kubanischen Geschmack\r\nFrische und natürliche Minze und Limetten\r\nWeißer Rohrzucker\r\nBereite ihn mit Liebe und Sorgfalt zu, um um eine echte kubanische Erfahrung reicher zu werden!');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ingredients`
--

CREATE TABLE IF NOT EXISTS `ingredients` (
  `cocktail_name` varchar(150) NOT NULL DEFAULT '',
  `spirit_name` varchar(150) NOT NULL DEFAULT '',
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `ingredients`
--

INSERT INTO `ingredients` (`cocktail_name`, `spirit_name`, `quantity`) VALUES
('Kotzer', 'Pfeffi', 5),
('Kotzer', 'Waldi', 3),
('Mojito', 'Weißer Rum', 5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pumps`
--

CREATE TABLE IF NOT EXISTS `pumps` (
  `name` varchar(10) NOT NULL,
  `pin1` int(11) NOT NULL,
  `pin2` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `pumps`
--

INSERT INTO `pumps` (`name`, `pin1`, `pin2`) VALUES
('Crowley', 1, 2),
('Lilith', 3, 4),
('Ruby', 5, 6);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `spirits`
--

CREATE TABLE IF NOT EXISTS `spirits` (
  `name` varchar(50) NOT NULL,
  `description` text,
  `in_stock` tinyint(1) NOT NULL DEFAULT '0',
  `pump` varchar(10) NOT NULL,
  `image` blob,
  `image_type` varchar(5) DEFAULT NULL,
`image_id` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Daten für Tabelle `spirits`
--

INSERT INTO `spirits` (`name`, `description`, `in_stock`, `pump`, `image`, `image_type`, `image_id`) VALUES
('Pfeffi', 'Leckerer Pfefferminzschnaps.', 1, 'Lilith', 0xffd8ffe000104a46494600010101006400640000ffdb0043000403030403030404040405050405070b07070606070e0a0a080b100e1111100e100f12141a16121318130f10161f17181b1b1d1d1d111620221f1c221a1c1d1cffdb0043010505050706070d07070d1c1210121c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1c1cffc000110800c8011803011100021101031101ffc4001c0000020203010100000000000000000000010200030506070408ffc400451000010303030106020606070705000000010002030405110612213107132241516114912332427181a115526274b1b2081672a2c1c2d1243334438292e153637383f0ffc4001b01000203010101000000000000000000000001020405030607ffc4003c11000201030203040706050403010000000001020304112131051241135161710622328191a1b1144252c1d1f023336272e12492a2f107151682ffda000c03010002110311003f00faf9838503a8fb52c813680723aa404c20098400708026100021004c200042001846000521a22000502c930819cf7b679bbad171b72077958c1f26bcff00a270f68cae32ff00d2e3bd9c5e8f56da6d764b4dbab24b50869dd41339f3ca43992baa657be6c0e8e863007ff61ce4e155ad4652936977fc8a161c46952a14e8392c2e57e397279d5771cfe6d5da66df15752360d1d5863b55cf6329c486099f2d638b28dbbb04c5b48980383bb9cf92e4a134dbd7a7d0d49ddd2845a52d93efef3afe99d55a626bbdd5b45a82c02aeeb534aea6aa824735d196430091d2ee6e37cbdd3a3791c60331c92adc53d8a15efadd369d44b9b1be98c61f76c7d0f75bf59ea7434b5b4d570456fac7063276ca1ad8def9082770e85ae2791e8ac453c6a8b156f2d6547b4ed172bd3395d5fc0c268d2e75823ef0b0bdb513b498de1edceff270e1df785ce4b0cebc2a5cd6c9b69e1b5a3cadcce38246921084000a00aca0320232810ae4b2300464302a62c9100442022626440888015c3828032cc1c290f238096064c2404c200842008020098401084000a008800612c8008e50191503263280c00f4480d6f59d8a2d4147490cd50f85b04ae9418e18a424e318fa46b80f924e5cab255baa31af15096c8e5b75ece6d11c6ecd65dc388c663a88e2f2f464602e12acf6c22a4787d24bda97c7f448d5a9bb3fb68980177d4801f4bab87f95578547cdb23bfd9a92eff8b3a1e9eecced12ba373ae9a91c411c3ae85c3afa162d1a33c6b833ebf0fa35172ca52f89d664d17413685659fe26ac529937ef93ba95ff005cbb077b0b48c9f4567b479c8e5c3a9bb5ec399e339d70dfcd35f23c768b0c5a6adf0dba094cb14797b5e61644707f658037e402e351e59a1614236f4234a1b2f25f2492f91ed3d140ba84290084a0053d5190c00a3205679480880153c8608988384202630989840ca044da8015e30d280328de8a403840f21510220644088804440c880261004c200529301503c130801502c931940cd735556dd69840cb559296e5b984bdf535bf0ed8ce7a70093eab9cd656f82ad79d558ec60a5e6f073abc5d358f74edba574d34e38125d6577f06aab38c3f1fc8e71ab769eb4a2bff00d334d82e5da119fe8f4ee8b033f6ab273fe0b8c69c53ca93f823bf6b5b1ec47e2ff53a3698b9f684648c4da6b4639991930dca763bf3690afd18b5bcbe467d6a977f7210f8bff275f656dee3d2c66363a47dc01e28a1aff0386e383deb9bc78707a7b2b69788dd4b9545b74939777363ea8c4d0d6dcaba0ef2e967fd1352d3b4402a5b38737f5839bf2c2e52df7c966caa54a94f3561c8fbb39fa1e82545975087cd2010a005e308010940030800200007280180ca9086da1000dbec9883840880200578f0a00c90e8a403040042880d8412261004c2000500040110044864c2042901004c20322b82062a40733d79ae859f50bed42b2281eda78de048c6905cec92371e9e4b3af6738eb030f8cdcdd5149db7bf44cd2ee1a96b66a791e2a98f680482d6371f30164d5b9a8a2f32fa1e32e7d22e254936a787fdabf435a1a96e313f70aae7de369ff0553ed7557defa190bd2fe319c76abfdb1fd0cad0f68fa8691c4435d08fd52ea68dd83f25629f12b85f7fe4bf41af4b78b39252a9ff0014759aced8a3164b8c5465f0d5b1c0d3cd510b3b9734904b48c8e8370c95abff00b84e0d433cde47a97e92f6b4a70a49f69d1e163a69f007671da10ed0296e121a8a6a83425adefa9a2eedae2490ee327804615ab4ad5aad3e6abb9e9b8357af5edf9ee16259eec1ba9e9cab46b087cd00214009e48006024004c01840130102c8c1300a604c26222041010023fa200c937a052019001039ca880c7a209010044011000280024c088022008818aa2029401e2bbdda92c76ea9b8d6bf6d353b7711e6f3e4d1ea49e3e6937813972ee7c35da5eb0afbfdeae3590d38a9acab7e5b1171c379c01f80546b5754fdb664ddd4a71f5ea492c1a6da6d3aae6a9134f70f848810e1136520607916b70163dcdf5bc935cb93c9dd717e1f2938f273bf1d8ea06ae392d2e89f4ed8ae4c686b66889eefaf24b49c9247e64ac3c4b9f29e852b8e29c22ad170fb272cbbd3355afa4d433b1c29aeb045d3218c735df70249c2bd4aa518fb516fde655b5d58539734a937e6d7e8691a829f51d13f75c65aaaa0f1b8486532b4ed3c8f6c7dcb5edee284d623a3ee3d670ebfb3aa9f6588e3a6de0760fe8c5ad23d3559550d5c8ef859267327e3eac6f030ef7dae19f9ad2a52ee67a8b59a8a5cbb33ed038e4821d9e77039073ce47b2b8688850002802b3d520024044c08980020028104755242094c44c70802008011fd0a4c0c933eaa980420071d5440281910322000500049800a00081a22008a2029400ae735ad73dee6b18d049738f0d0064928c8cf9d3b4cd593eafacee20324768a6c98d83abfd5cef73f90e165de5e727b3b9e7b8a7158d05cb4f567277f72dcb299ad679178fb5ed9f35e66b5695596647ce388f119dc4b56571460718e07a2e3cc644a4f63d4f89ed881c1d9d01e385ca2d3d09cd4b973d0ac1c95d122b48b32081d72d39fbfd41fc14d4992a7371ca5d4ae92d9454d701591d38867e8f92218247b81c15628de54a324d3d3a9b3c378f5d594d2cf345747a9f45f653abdd3c51e9eaf941998cdf473751233f501fc381e5d17abb7b88d58a945ff0083eb1c3b8852bca6a749e73f23a7156cd2150201498159480280226044c060102229010a0410131131ee8011c1006459d1480740114406081a220644000a1801200140d010043d14580a802200e77dac6a37d05a9b69a420d6568cbda1c0131839db9fda556e2af244a57d731b7a7cf238955543226b8bc39983e2716118fc71f9ac0a9ac8f99df5495597b49b66a35b0c50cc4b1c1d0bfc4d39e083ff0095975a3cb23ce548c94da66c3a52d7495d248eab943216380dcee1a5c4e002e3c341f53c2ceb9954f6626f700b2a35b9aadc6d1fdfef236a5b95aa7a6a56d0528866eefe980ce237ee236ee3c3f800ee000e718f34a8519c64a5cd95e3f9787efa1d78e5ed955a51a56d04a4b77bfbb3d7ccd483b2ef70ae1e5cbe2778bdfcd491091e9899b9a482739524b241998b1df5f6a958d748f6b03c4913980974726782dc7a9ebe5857387d7746b1e93d1be2152def230e8f43ea8b35d05e6d54f58406cce1b6560fb320ebf81ea3ef5eb694d4e2a48fafd1ab1ab05389ecf5cf55d0e82940012022604401148060810ca427b900e500c62328420613003871f8200f6b3a29087511910011d5031d03014001260028002434029001002b9000f08692e3868e49f40393f9288cf9eb56dc9f75bed65c2401d13cfd09f41d300796063e6b16eab731e1f8ddfa9b6b9baedd0d4a5739fe2c90b3dac9e26bcbd631374844b01e7c4df10715c6bc331f233a7ed1848aba682192264ae6b25c17b5a701d8e991e783d1663ee3a42a4e117184b09ee79e49f79e54738d0861b796541dcf29a6182e8df9381c8f35d13c1168cc5b402e70630963a33c839e73feb856e9536de51354a4939c96ebf7f91e2a88a3371677ae732186305acced66e0ec38bbc891c0da78e4f0a15172258d3bfbc232a94e9b74fdace1f7edf2ebaee7d03d90de32c9adcec3637b03a16fd96e01381f8070fb805e8786566e3c8fa7ccfaafa31c43ed341465bfefde7535ae7a8e82b92621500440042601400ca4010988298984042104b53015c38401eb61e14843a88c23aa0027a200810344498c881a0148181260028002005210061356dc7f45e9faa930e2f9c8a68c03f69fc67f00095caacb960ce55ea7674e523e77acad754787606edcf00f9633fc160557eb60f96f13a999e3a9e29dc18d25dc753cfb2e7b185524612ed334d13df1bb21c4378fe0aadc49765eaf7953da35b6c334bcb237b8609c81e43a9fc164c99d614e4d652283ce3dd20003d3a63d5302f89c07cfcd748bee20d64e89a22cb2d755dacd330bea3bcdcc89ad383f689cf9f4e56e595175797c4bdc3ade55ab4145b7afeffc992ed574c416cd44e8e81a2aa9651989ed8b21e7827a0ea0920fe195d38b5a72cfd4459e3bc3e56d79d9d14f0fbbaffd64f2e8bd43fd5bbed3fc73bb814b264c0c661fe648c7e047e2b8f0e9ca9d6c4d61a35bd12ad5285c3a7358e9aee7d30fc0270723a83ea17a6ce753ea1a7413c90314f548029804268414c061e4a40384080eea0262637529a10c53062bba14091e8629016288c810036500407086343652180a0680424c0548004200080224069fda344d9ac503097364f89cb1edead26378ce3cf82aadd3c4328cee2d3eced252382be114f50f607821c4e30de000318fbb83f358727cd23e5b73579e79eb83c7510c8f05c4839cbb6838cf8718fe2546506d19934612bcba9e0025706c8eabef0b8720b47da1f90c2a75bf871c4bf164e3a230524c3680c7966637020796e7671f25424d74269b5aa3cbe43d943002b4e318f2ea9203d54e46701dc72067cb8eabb43099092ea76eec9afd6eb656590d4c8ef888ee21a006920b5d0b981c31ce771031f8f40bd2f0dab04a0a5be7f23d0fa3b75468d6a6e7bf33f3d5346d3da5eaab4da35309e38ab1ccab8d950f63a3da0bdb2169db9e4090340767c98debcab9c42ea9d19294b3b7d3f7836f8cf16b7b7b84b5e592cfbd3e9e7b3f71c66a63a7bfea58df14cf8a07ccd30ba56f8d871d460e33e2763ee0560aba552e799675c6e79ee1b7d19711e683789779f54d1b8be868dc5e5e4c11e5e7ab8ec192bd4ad8fb0c7d945a5324046405f3400e14844053c8870980c9811dd4204d05a549087cf29e4456f3c14981ea671ca988b14479220020200250c682121a0a43014805280020007aa400480d43b42245ae9307199c9fee954ef1ff000fde63f1ecfd8a5e68e1155ff1ef1d70e2162a5991f2daadf3953999f2eabaa4569ac9ad6a66869a6e99f12cfbf5a4515e7a3c1ab119040eab2fc0926471dad233cf9a7d016e567a93d7ee51245d4b97ca318cfbae90d5e1119ad0ddac37d8ececa0a87b77cb14d055358de33ddbcbb05dd5bc1c7e2b5285c2a4a2fae84edee15b4d4f1969a7f032dad357526a686d0ea78aa62969e99d0ced99e5ed27bcdcdda493c613e217ddb42315ba4f3f13b717e214af55374e2d38a69e5e7ae4c4e9f0d374b7633bccc0f3d318e3f1eab3694b3523cbde54e14f1790f33ea8b7002db42074f878ff00942f76b63ef70f65791e82864808000ea9e40994f220a320337aa9644393c2790214f20c20a08872986057fd54060f534f0ba112c0a20140c58a3318e5c493ea90cb1360881218c93180a400280171849800f54b200480d3bb46e2d148ef4a823e6c3fe8aa5e6b4fde6571c59b2979a3853c6eb8c9ebb8f2b1a2bd7c1f2cacbd7c1739bc74e559e538c960d3f571c3a8c0ea43b3f3597c4f4e4c789566b2f26b51b770793d1664767923258c22ac970c33c47eae00ca12725a23ac294e5b2c85f4f2c2d0e96392307f5d847f826e128eebe44e542aade2cb29083b9cd20e0792953d195ea26b467b184803d3d574597838bd599eadb5b68ecb65ac2eccb70efdf8cf01ac7b58dfc7eb7e4a55a92851a535f7b9be4d1dabdbc69dbd3a8b7964f569de2f96f07a0938ff00b4ae54162ac7cc5c21735ed3f33eaaa26eda0a31e90b07f742f7517a23ef70f6579171e89921494b202e5191e0994f2180e7dd3c8821dca791606ca620efe134c020a7900e534c4071e1007b1bd174c901c148071d5030a008964642818424c6884652001e120014008545800a00d43b4723f40c1ed503f95caaddff002fde65f1ad6ce4bc8e19c1b8c9fda2b1e0bf887cbeaff30f4bda327dbaab98394e3d7a186bfd86192920baddee30da6c90e5a6a671974a49e191b3ab89f6ff00caa75ec9dd4a3ae12ebfa1abc3fd1fa97515735df2536f4eb297f6c7e8de835a6c55f531b5f61d274d4144fc6dba6ad79df20fd6652b7c447b1c2eb4ad2de86d1e667b4b4e074282e685351fea9fad2f72d91b6dbb4f6a10dc4bda25453171e1966b2c1046d1fb25fc9fc55fa595ec24bdc683a115a76b2f72497d0db6d9a66f6c7662ed3b53173b822aa829a56fc95c8babba7f238ce8fe1ad35ef5fa0d59d9f5dab622dada2d2daad98c12294daabfae72246784bb1e5d3a6546a5bd3aabf894d3f2d199d71c31d55af2d45dd25cb2ff0072fcf439a5fbb356b9d572e9f15a6a68d9ded5d8ee3186dc29999e5edc713463d5b93f7f458b75c1dc576d6edca2b75d7dc78ebff47f2e5f654d4d6ae0f7c77c5ed25e5af81af56486ab4dd921cee6d2cb52d639bce5af31b81cfa6777cd66ce973dbc22feeb97cf0cf3d715736b087737f9685564cb6fb6e3e7df01f3042a9462d568a7de3e09aded33eb3870da6807a46cfe50bdb4763ef315a20f927925815c906042e400b94f230ee46458207729e4581f7650858093e152111ae4201c394930239dc14f22c1ed6f45d080e0a007081841ca591850043ca0610931a0a400232900084b2026d48007940f069dda539b1e9f85cf21a0548e49fd972ad72b30c19fc560e7692513859923fd25278d9f5bc9c164462fb4d8f9855a53ed3d9360a382963a5aab9dc18e96df4458d3045f5ea6671c470b079971c7cd6853a7ccde7a1a5c278746b49d7af1cc218497e293d97977999feafc94b5f1deaf8d82ab536d3ddb5c03a9ad0cc7fbb85a78de070e90f39e984e79a9a2d8fa053a4e9bed2ae1d47d7f0a5b463dc8c2d2df9971bc52465ae7c15534b4efa99661bbe263397d3387259206e4f8b03d3384460922796de59e7b63b525d28e77c9f1d4933a95cc89f4fddc4c32e260d9435eefb6d929ced71c35f03812dc64f78a5d0849e7466e1245aa48a29edc618ea21b79654d33662f85f505996be26b8ee7163cb810ff00aed0c1976326cc0e32e5ea64a9f5bdc6d5553d35cad72be1a688bbe9f6c334af7caf731b92430f774fb1d2b80da0efcbb734b4f75e00e316f28de6b68adbac6920922addb5548f268ee707fbfa2940079f6e40731dc7914a693f596e71b8a2ae22a13dd6a9add3ef5f9ad99c3bb4ab2be9a99b713410d1d67c6ba0ba53c4711c554e682248c7fe9ccd1bc7a1c8ea49589c5682a30ed69c77797e67cf7d25b3938f6fcb892789a5b65ad24bc258f8a68e7d6b7b63bed039ce000972067d01e179da399d78bc7531fd1fa5295ed3583eb360fa28f9fb0dfe50bd8ad0fbaa14a6314f2906042501817f1406019f74060994004393c916876b91916080e0a926181b729262239dc200c8b0f0bb1cc70802c0504883aa4319022243267090d0c93022400293014a078112c8cd33b4fa1a9b96967d3d253cb5151deef6c513773dc035c4e079ae7516752bdd67b26a2b27cacf91a2f355970fa3778dae182dc0e720f23f155572aa9afea78faaf966f9b4c1de74cd9db472db6097063d3f48cad7e7a3ee154096b8ff00f1c40e3d32d5664b4c2ea6edad3e59a5d29aff0094bafb96de66235acd1d7be3b53a2754c734c217c2c9062a5fd5ecef5bcd3d4438ef80906d70693c8c86f3968b434124b53cf436c8a9679eaa5ee2a2e5525a6aeb04223350f6b701fb3a378c9f519201c1c2e4de40cb4975a0b352cd5971ad829e18233348e7b817ece990c1e37790e015d61a6e45c64f646734a6b3d3fa8daf7d05d607089ec8deca822076e78f081bce1c4e0f424f1d158a356151662fe3a7d4e7528cd6eb3e46f92d1435d4e20aaa764f134822391a1c184742dc83b5c3ae71e9d55a4704f1a335ab6d0d5e86bab69e0709ac9244e9a69e4700f2371cbe4738f0236e1ad683b49748f791801cce9ccb1861ed734e36fb679698019bc51cb405f83b7bf8da67a67e7fb4c7341fdb5cebd2ed294a19dd197c4692738cba4d383fac7e0d6179b3e30d0d4f2dc759d929e944955592938a78985eee41fb23a633d4f4fc0af2d462dd4588e71dc62f0684bed3178c60fbd9fc1c6478406f1ec30b7cfa26fa951483021384649605ca321810921443029729643042e4645826e4641a0efe134470112290b0307e534c30339de146446518558390e0f2802c0824861d52185202240440c20e5260148005218a50314a4c0c2ea5a78aae8a9e099ae7c12cbb646ef730905a720381041f7041e12c6b838d78a70c3ea6937cd08db94e5df1f47716b321b16a2a2133d9cfd9aa8b6cbede2dca128f4c27f23325679cf2c9e3fa9732f8e8fe67ba286a6d76fb955dccd2fc654d54d5d37c2c9be26b446c6460120670d66791e67380a2df3634c60b54e9b8465ced3727978f77e86896d10d454d75748d84dc58c653cb33012feef1b86f79ce72034e1b248d0034eee542474345d63da847a76ad90db8daaae39220ff008a7553a46c67c5f5a38db8dbe1fadbc0f2c6556a926a198acbeec9de9515297f13291f3ceaded3e8f58d45dc5c296dc6eb3490b69ae7471cf4e71181b5ce6f78e638ed1dded7b1a40c10ec8c2b91a6dc6339470f1d1e5fbbc3c41ae5938c65fbf81e7d3baf6d5a5696e7555f4d4971b9bcbd94504ec97ba6479190f8e29238cb24201739c481b0e18e24a6e829e1382c78b7f25de293d1be67ee47dafd9df6c751a8a3b7babe7b6d5433b98da8ae8a8ea29594e49da4630ec92791c35b805dbb1cae34f884e355d3b8e58a5b6bd3dd95e7dc46ada47953a596cea1a91b4f7dd2aea8a6b8c0ca3cc754dae67d2c4236bc174980407801bbb0e25b96721c320eaf8a28eb17868f654d2d4ea2d276d928640cad86582aa075ccf2f31bb8326c1d5cc39200fb58c0e887e59385ed1956a588494649a6b3b69e4612cdd9fbad34c6035b456eb6ec2e7db34ed0b68e2948c9fa498e647839e705b950506a2f9525e470a369272e6ad533e115cab3f16dfc52f032f9cb5a4e0640381c01c2a793d32585810a4d8f02392c8c4270964052519010a43c0a5c9e4302ef4730609bd34c4d043d49316060f4d484d0e64c852c9168ccb0f0ac9c703b4e50182d69ca5918ca39184140f014011004093019458c0503014805c240622ff8105267a7c40fe52937a9ceafb0722a2ed4aae2ac9296e3434d58e64ae6192866ee66ea7fe4c9c3f8c7d42ac764a5b1e4e1c66a539ba738a93cf4787f07bfb8cbbbb45d3ce2d15155516f91c338afa57c5fdec11f9ae72a33ef3469f16b5da4dc7cd63f530f77bddb2b2d93c166bdd9e29df04aca42ca889ad8e5734ed76cc8c788e7a7deab54a735ae0b74ef2da7b548bf79f1c6abadbbe9da4a4a37db0410412c5492cd1c85e69f0790f8b01ad7386d3bba12496920854285bd295492a99cf73d9f93ea6dceaff094e924d77ae9e7dc790da2db35c6696e14b2d5574a1af8aae598b0cae0d0eda0b71b5c1b823cc81ec53756af2e60f096e8fa3d0e01c268cb96b5273738ae594a4f0e4e3cce3a6145e358fe249adcc3bec4ff00d35dfd35597c74b5cf8cd3cb109dd042c930d95a1fc3981c791e44e4f055c85c374d73add7cfb8f2d77c0a84ee672b778519c938add422f1cc9bf6b0fdacede4778ec735feb6b956c8e9a3b7d5d3434d4b512dcae7348c653492ee73626b98332c9235cd222770487631959d776745a50a79cb78c456f8efeed7a9e6fed2a1995492518eede983eb1d297eb0699d2569b5dcb50da854d2c1b248dd52d94b4ee24b086eee993e1e719dbce32bd1dbd1a91a7153dd1e6ee38c58464e52af1f8e7e9932f5dda6d923823960174b837f5e9a8dc5a7df7bf6803dd595424ccfabe925a259a6a72f18c5e3e2f06b549da7d4dfefd416da4a3a6a3a6a89364a249bbf9cb39cfd51b23f2ea772856a6e106dbd4ab63e904af6f29dbd38a8a6f5d79a4fe1a2fa9b593c0cf5c2c9c9f42ea213c25918a4a32182a7151c860525190c0a4fba324b054f72596182b2e48300dfca698b04ef14b2180f789e44132e027cc2c1b1b3a2ba552c050058cf3498d0e0a448280082800a0007c92603051634140c529301521987d458f85a5fde07f2b927b9ceb7b07cad72a632ddae7238b5903247173e4e5a417edc0f5e55a75945c618d5ff00d9f34af6aea55a9524f105ab6f5fbd8c151fd234ce2da392a08690c1dc484b0e4670d19c1e0f4c71e89f6b0c6af0f7c3ee251a17116e341f363f0bd1e56561e997aad37ef39e6adaf7b9ac12c34b3b371dddf52309e3a82eda0fb7544d47385aff00d02ab5b3996db7bff7d0d064a664b144c0ef11907c460873668c1c86edfb27dc7de0aaca8cfb4739cb315b69b791bcb8b5bd2a0a9d1a389f579787e69bd7c0f7d046d9a17d3d4d30a88dee639c7bcc6edb8da70718231e5e8a954b0abcdcd49fed9f46e0ff00f93f86d0b3569c5284a5eca6d3ca7cb8e5f1d30b0d6be27963d1f77b85e9f5a2e30d053b2a267c3dd8ccce64a7c639f0f3ef9ebd15ba56f25054e4b55f91e538a7a7d6aee65736f293d64d62387eb6e9bf1f7f81d5b4d51c1696cb0c74f14f09a76c74d4b2c9288a9656b3619981a72ecb437209c7873c6e2174a9632c4654ea7235be3197bbd5f4d5f43c33f4ae9d6ed21756aaae5b7159785a755d5e16fdda2c1bb5aabeba2119a690b3b98837bd8e1635e5a0e32e735b927d4adb8a845a4dee787fb55dcb99d258c2cbc2c617bb5c2ef369bd51d6545ba9db3c8f739b4afabccf3176583cf9279eaa2ebc1671ae1e3decbd7563755610551e7d473cb79d17e6fa6c7a3b3eb73a875cd230bb79a7dce71008008613c67f0542572abd27248ddf47f85cec38bc69c9e71be98d5ace9debb9f53b46ef2f45959c9f5f0129360238e0232054e784b232b2f1ea90f023dfc709640a1d226056e79400bde0f33ca430779ee8c8609de7ba790c00cbc7251922d1b833a2d2298e0a007675ea91245890c290041c79a003b9000ce520082931a0e7dd2632754862948661752ffc152fef2dfe57289caafb27ca773ab10deae904c5c209e57378eac21e487373c67af07a83e4ae3a79e59c1a4d6de27cdeb5c38d4ad4aa26e12d1e3a61f326bc73f105de6a7afa36c34e63a63048e74625c440873580bb3d03b7373f71f65ca9539d19f3cf5ce8fc37d3c746916eeae28de51ece97a8e9b6d6744f3149bd369292cebd19aaebea965d292b1d4c7bd73eb637780789f8876ba403ae0bb3cffaaa5469ce855873ac2e57e3f7b45ee5b1a977561794aaba0d3cce1e0de21872c7737d4e79501ed6d06c635dbe0076ede1c773b39f5f20a74a2a52a9cef0d3d3e088d59d4853b7ec639cc5656134fd67bfef63d74f1c71191d181b5b2801eef4c15184a739c7b47f773dddda8eee951851acedd68aa249a5cda38c9b5aeebeba1b4da618278e281ce6452b80daf270d71f471f2fbd76756b53a939c573453c38f55a6ebf4312bdbda55b7a542a354ea38e632d70f2dae59f45e12d97ded355d32d8c7b292f0628a40f15b0b5bdc39ad7b086c99e707033f3f65c69acba0ffa5bd5379dbe7e64eb294617bcab55520b11693d149369e31cab678d367b197d2151456e8a2755bb736e1ba9e6daf1f450905ae7386093971071c1fa31cad5bba356b7f2f4e4598e9bcb3a2f76de19303835c5b582e6baf5bb66e12c35ead3c61b7a3d1b79e9ece86c378ab863d3ee91ae3df436d6d0edd9b5bf5ce5e09f22d3c0c67d70bb42dea394a2d613973f96da7b9e876bbbcb785b466a596a97658c63ab5cd9eb95ae37cee27677562bb57d45535ae63248657b5a5fbb9d873ce07a6155ec952a0a0a59c68697a3d752bde2cee1c1c54b549b6fc329bf2d3075e73f93c79acec1f52ce45df949a18923f0005119439c802a73900526420e0a0052544656e725902b2ec728180bf8516c30297a6a432b7cbc143906326f8de8b58cf0ee4891630f29017028191260448084a18101420224c6865119103402931985d4bc5152fef4cfe0523955f64e15a2ae3496cd47ad27afa18abe859047de534ad6b9af0eab6c79f10c647787dfd177ab1e6847278ce173842eae1cd6569bff00719cd41a0f445bd9476faa75551ddaaa79e9e98c12bb1501939600720b438348eb8ce156552b28b94259c1af5b85f0c4e146b41272d161b5fe0e75ac3b15b556dfa92d56bd591495534b53148c9a06c8ea77c4cdf87861c8c8c81c0e894aeaaad2514d7bcaff00fcfdb39f253aaf3e38d3af99a9bbfa3bea235e68a9ef167a891d08a86f8e56b5ecdfb38e0f3bb0a2aef2f581d5fa3f552e5856fa965b7fa3f6b49ebaba8295f6a75451491b2568ab73482e89b23480599236bc1f9a9c6e633de9bf9151f00bb8e90aa97be5d0d934c7601aaeeefaf8d92daa316daa928a7df52e3b6460697630ce478872acc2abce9132ea7a337357475169e6662dfd945c459b545756544115469b91d1d451ec323a4c343b21fd3690720e3a0f7566170db5caba98b2f46ab763713a93c4a9e74c3eeca7e4d1bfd93b36b752d92d370b84b572d4555aaaae1dcb5e18c8cc41ae6b7206483bd39d7a99e583c1a1c3bd18b1851a75ee22e52945c9ace1689776bd4da2fb61b4e938aaebdf6f8e7b74565655fc3bc093e91b2b37e0bb8c90f039e894a6e51e59499b152c6d6c2a3b9549382a79c633aa6bbf3de6361ad96e3da81ef618a9fb9b3c6d14d0fd4837425e58df605eb9d44bb2d05655655b8dacac6211d3bb2b3f99b73870b3cf739d4a1c769507b922b73b290cacb920297bd00505db9c9001ce5124545e96405ce4e101823ba28b248a9d9212194c8e3b4a1860e80c3c2d933cb0148076f92405a0a18c39510220021001270930202931a1b3948602500048661f51f1474dfbd307e454590a9b1c1f465e23d3fa9f5cdce5a315b0d251778ea6738377e2a9a0724103ae471e4acd487328c4f15c3ee236d73735651d97e66cd3dcecd7bb1693aebcb0b6ff005b3cf576e20bf635e6b3c4cc8e0f1b71bbae1569d3945ca31ce86dd2b9a1734e854af15cf26dc7cf2622aed165b7f6dd4b76b6dccd5dc6b67b932be977b5c295ed87701800386493d7d17094aaba787b634f89de9d0b7871155a94b33973732cf7474d0d4346766153a6bfae7a729ef50554d79b231f054b18e8e384ba72d19c13e9c96f2b9caa4a494651d8ed6f63d8aab4e336f997c0c9699ece7519d13abb454175866d40cbb52385619e66336f714f2e0388df80d763a6395d5d472a9cdca71859d656b3b58cfd6ce8fbb6371ecff47deae1a269ed0cab125ced3ad0cd5956e99c0b99039a2421c46e713c3403d5598c9e5e342ad0b3a9d82a2e79719e5bd754b73a0e989e8f55547690d81dfecf75b949431bbf5b6523632efc89f92ed86961f5256b285dcaeb1d65cafdd14bf267ab53363a5a4829223ba3a2d3773841cf5d8c859fe52a717959237b0508a82d9539fd17e85bae648ef1a3b525bdb1e6a29e782d7c725c1ff0eeff0039ff00b5351ce59cf89d48d5b4ad4974c47c75e5fd4d12c4d73bb4ed4f3ba27c6c7f7a621237697445ed631d83e440e3d93ad28ca9ae532b83d39c38e5773584f6f25a2fa1bc3b1e4b3cf78b62890e024c792ac70a12194bce14491e690e500563d526484715102a7149ec30b4f0a191a402e464656e7232054f396908606fec3c2d833cb32801d87949816e54461dc802672800838430265202679400c0a4c682912220661b5193f09463d6b611f32428c8e753d93e60aeba545a6f7a8e9db146e86ed1be9de6469c9609776e611e61cd19ea38c2bb18a6a2bb8f9b5c579dbd7ad1e5fe669af778779eb76a3b7c8cd014f299e959609dff001734addcc2c74a24deddb927d08c79a8d4a4e3ceff00116e8df5197d9219c764f5fd4d96922d1afed460d536ad4f4b5357719aa8d445355471b206be17740fdaee5c5a307a72b32b2ab8e47b1eb2ce360eea5754a69b97f578771c7fb28a1a83a1bb56114326d8ed6d8c069386b849b9c063a70dcf1e8a75936e382870d72ec6e5671dc6e3d94e98beeb7ec6ef5476c95edafaabcc6e86a679a56b4b228e1cb7bc6e5dd06075e98529bc57e682c9d2c6957b9e1d38733526f47dc6fd638ae7d9f688b44559532bea2dfae1b155d446e786cc1c1a1f92ec1737c47af52dcaeb06db4df7b39cd54b1b6841cbd6e749bf07bfc8dfaba48b43ea57c8e9e9e9e9ea7558aa7174cd1f412d2012388ce70242f19fb9778eb2c35d4e77738f0ea8a6a4a2a7513796968e3abf89828f5a5927b342dacba6dab96d35548f86185d2bd924f2970cf01bc371e7e6ac3b6aade12c799932f487872a2a556b2727192c24dfb4fe062ee1da7450ddf5156d1dbdf5105d2ae9aaa18ea9fb3bb744c0df1069390719c03e8ac3b6e64a32312b7a554e95c57ab4a9f329b8b59d30d2c6abe9a9ebd0f79aed4da92ed7ab916beaaaa1601231818d2d6bda3007981d33ebeeaadd45456226c7a2b755afef27775fda92e8b1a2faf99bf970c75fcd671f447a33cce7827dd02039fc7451c12c9e691d95168793ccf498215df5572268a5ceeaa321956795124825c147a8cacb931885d94031643e12811d018785b0678e0a0076943045a0f0a230e784010140072800829300e5030829304303c2430140cc2ea7cfe8fa720f22b2120ffd493d97990a9ec9cfb52766d4176aaa99edb28b754cd2ba4921ee7bea599e49cb8c5d58f3faccc15d23370f13cf5d709a359b943d46f7ea9f9c7f33925eb4454da6eb1daee7571415d545d2d30a72d9992463ab0b090f8cb73c6ece413e6155bdbeaf6f1eda92f57aa7d3c9f53958701b6acddb5cbe5a8b6707a35e2ba35f3390eada38e0a98d8c926a91239f873e8a4881da7008ce43f3cfd53f7a95b5ff006f172a9cb1c7f57e5d0ad7de8fcad5c7ecce751ff6e3e66b069662e0053d4123f56171e83d30bb3b9a0befa384384f11c623465a992a4a6b90398a96e0d61e8398bf891ffefb9739711b58e8e59f23bd2f47b8af2e211e5f39236fb5d2d43f73eb2ae9e9a26c464df3cef95c4038243181d91cfaf55c25c669c1b5429b963bf440bd0ebaacbfd4dc24bb97acff0023a65a2cb63a79e0a592575655c8c9a567c4b8d2d33db1f7848daccbde331380f17248c8190a857e297b522dc1a847fa77f8b366cbd12e1569ebca0ea4bbe6f3f08ecbccde21d374d7aa1b5ba7b6d3d94c9592776ea3a38e373e0316e0c0ec721d92edc73f5381954edafaada55956a12ce9d738cbef5deba335388f06b5e256f1b6b8862394fd5c2c63b9e34f1269dd091ea0bdd5d2c77086dc68a4747f0b726f7d55237ca6eecb431ed7756804800e4f2703d6585dd5af43b4a9514dbdd2da3e18efef3c0defa3d43ed5f66a108d18c3672cca53db55978c2d92ef3abd3698b7e99b6cdf09decb57318fbfada876e9a5c7419e8d68f2637002759b71d4f4fc2ec29593c52cb6f76f7fdf823c6f909e01550db7a1503ca06984b922456e39f25160538cbb84993423dab96099e77850686520755cd9242bb8512452e760a43456e7a131e0adf271d52930c60e8ac770b7326660b01ca03058d250c0b01511841400414300a401ca064ca061694980c7aa4003948661f52e7f4741fbe41fce93e88854f64c6d5b19309e295bba2937b1ed3d0b4e723d5746524b3b9cfaafb38a0a6a89a6b357d45add51235d3b2589b570bff093c6d1ecd70f9aad736f0b84bb6f5b1b77afc856b09da2c5b4b95754d653f8ebf338bdfab2be8aa1b6d9aae9a92ba9a693e3699d2884b89943c3e30f39735cc0ec1048c49d72dc2c3ad691a7564a516f6c3dfa346cdade76d4e3194929755b6cf7d5ecfc0e775b593b046daabc52bc38c7b9a6e2c64ac036f7833bb9070ec1ea373baf0ba2826972c1fc343bceaac62538e3fb8f15108da1f03eba9a496589d187c224a893c4d6803c2d3e10438e472770f35d654ea496541efd5a4b7faea5495eda53599578af279f91d6348767fa86f514317f56ef95a1b09a6334f0b2df1f76640f397cae047d50d3869c8e7009525617156a3c6229ebde549f15a0bd58294da5dd85af8bc23b758bb3bab640e96e7a82d36b8627364905b5c2b2a1ae739c5bbaa66e1a4b8939630127a1e177a5c2a82ccebc949ac75d3c9952a710b8a8bd5c53f2f5a5f17a7c99553694b1daf50d4551d58699b24ee7c354fa2926ab631cd01cc33cc5cd193d5e180fbf2bace7655a4a2e7eafe149a8fbf4326370ada52fe2a4e6de64d372f0597a2c7f6e0e9d67d1763a0a9a5b9f772dcee5130182e570a83532b41e73193e1683d7c3c2d5a74a9d358a4b08b6a8c26e35aa3736b67279c78ae8bdc7b7503f6d1b00e8e95a3f271ff04ab7b25cb7f68d60955305f626fc143044df91c28934c42f48909bf07aa18d219c4104f92e44ca5ed09343282de7d973944922a7b485cf0491e77f5c612248a5dd147032979c0290ce88c77856d99858d7a00ba377ba7902ddd948020a0020a3230e5261826500820a0610526036e4861dc8c8cc46a3e6df17b55c1fce127ba39d45ea98da8e1f27f68ff153654357d43a828ec6d6b6713cf33c6e6d3d3337bf6f99f2002ab715e145273ea73a9515339a5d3b49d31766b29eed6b32f767c30d65347386389c60070e38c1f255bed917ba7f52a3e21424f138ebe3d3fc1e8b4d6689aea98e0a08ac6c96a016331411445d9f07076f072e18e415385784de22fe27783b6abb72fc11c96b239acb55455d0ef73a9ea4d34ed940e0f4c13e60bb8ffac1f318c051e772a13e9931ae21d9423560b54f5d16ccebb3f6855553a5acb68b6543e6b85445baae619ff67877ed8bbc70e1ad23ab739c3475cf3a0eea6ed614d3c656be4b65efea42f2f673a6a145eaf77dc8f446cba9922a4b735fdd06f79355ca711176e2376475c7b0040e0103859f17051c630bbba7efc4a8e170da8517a25ac8db34ee85aabcd599253de35a5a26ada8f18e3c9adce1ce3d71923a67055fb5b4a973a47d58f79de970d939e67af8bfc8ec36bb7d3da6df4d434addb4f4eddac1cfdfebc739381c0cf1c2f4f4a9c6941423b237614d538a8a5831fa88fd0403ff00709fee9ff54aafb258a1ed1ae3b955b05e29770930177609f751689215c547074c884a096481fe4b9b24990b922421728b101c014b0892c9e79235cdc4793caf628e092679a56ed0a0d3c124cfffd9, 'jpg', 1),
('Waldi', 'Leckerer Waldmeisterschnaps', 1, 'Crowley', NULL, NULL, 2),
('Weißer Rum', 'Lecker', 1, 'Ruby', NULL, NULL, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cocktails`
--
ALTER TABLE `cocktails`
 ADD PRIMARY KEY (`name`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
 ADD PRIMARY KEY (`cocktail_name`,`spirit_name`), ADD KEY `spirits___fk` (`spirit_name`);

--
-- Indexes for table `pumps`
--
ALTER TABLE `pumps`
 ADD PRIMARY KEY (`name`);

--
-- Indexes for table `spirits`
--
ALTER TABLE `spirits`
 ADD PRIMARY KEY (`name`), ADD UNIQUE KEY `spirits_image_id_uindex` (`image_id`), ADD KEY `spirits_pumps_name_fk` (`pump`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `spirits`
--
ALTER TABLE `spirits`
MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `ingredients`
--
ALTER TABLE `ingredients`
ADD CONSTRAINT `cocktails___fk` FOREIGN KEY (`cocktail_name`) REFERENCES `cocktails` (`name`),
ADD CONSTRAINT `spirits___fk` FOREIGN KEY (`spirit_name`) REFERENCES `spirits` (`name`);

--
-- Constraints der Tabelle `spirits`
--
ALTER TABLE `spirits`
ADD CONSTRAINT `spirits_pumps_name_fk` FOREIGN KEY (`pump`) REFERENCES `pumps` (`name`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
