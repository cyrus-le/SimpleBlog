USE [master]
GO
/****** Object:  Database [SimpleBlog]    Script Date: 10/29/2021 7:49:46 AM ******/
CREATE DATABASE [SimpleBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SimpleBlog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SimpleBlog.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SimpleBlog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SimpleBlog_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SimpleBlog] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SimpleBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SimpleBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SimpleBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SimpleBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SimpleBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SimpleBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SimpleBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SimpleBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SimpleBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SimpleBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SimpleBlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SimpleBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SimpleBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SimpleBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SimpleBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SimpleBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SimpleBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SimpleBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SimpleBlog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SimpleBlog] SET  MULTI_USER 
GO
ALTER DATABASE [SimpleBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SimpleBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SimpleBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SimpleBlog] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SimpleBlog] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SimpleBlog] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SimpleBlog] SET QUERY_STORE = OFF
GO
USE [SimpleBlog]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 10/29/2021 7:49:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[ArticleID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[ShortDescription] [nvarchar](max) NULL,
	[Content] [nvarchar](max) NULL,
	[Email] [varchar](50) NULL,
	[CreatingDate] [date] NULL,
	[PostingDate] [date] NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_Article] PRIMARY KEY CLUSTERED 
(
	[ArticleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 10/29/2021 7:49:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[CommentID] [int] IDENTITY(1,1) NOT NULL,
	[ArticleID] [int] NULL,
	[Content] [nvarchar](max) NULL,
	[Email] [varchar](50) NULL,
	[Date] [date] NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[CommentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 10/29/2021 7:49:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [varchar](10) NOT NULL,
	[RoleName] [varchar](10) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusArticle]    Script Date: 10/29/2021 7:49:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusArticle](
	[StatusID] [varchar](50) NOT NULL,
	[StatusName] [varchar](50) NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatusUser]    Script Date: 10/29/2021 7:49:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusUser](
	[StatusID] [varchar](50) NOT NULL,
	[StatusName] [varchar](50) NULL,
 CONSTRAINT [PK_StatusUser] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/29/2021 7:49:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Email] [varchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Password] [varchar](max) NULL,
	[Role] [varchar](10) NULL,
	[Code] [nvarchar](6) NULL,
	[Status] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Article] ON 

INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (3, N'Show ảnh từ Sony 18-135mm Có Hơn Một Chiếc Lens Kit?', N'Anh em trên khắp diễn đàn nói chiếc lén Sony 18-135mm có độ nét ngon lắm, nhiều khi còn ngang ngửa 16-70mm mình đã dùng một thời gian giờ chia sẻ cho anh em nào có ý định mua lén này thì tham khảo chất ảnh nhé.', N'Cảm giác đầu tiên của mình thì đây là chiếc lens rất nhỏ gọn trong khoảng tiêu cự 18-135 có lẻ đây là chiếc lens nhỏ nhất ở tầm tiêu cự này, đúng là một chiếc travel lens, mình có chiếc léns để so sánh cho mọi người thấy. Ống kính Sony E 18-135mm f/3.5-5.6 OSS gọn nhẹ với kích thước chỉ 67,2mm x 88mm cùng với cân nặng là 325g. Sở hữu tiêu cự 18-135mm - zoom 7.5x (góc nhìn tương đương 27-202.5mm trên hệ Full-Frame 35mm), ống kính là một công cụ cực kỳ hữu ích cho các tình huống chụp từ cuộc sống hàng ngày đến chân dung, phong cảnh, thiên nhiên và nhiếp ảnh du lịch', N'knightfxcker@gmail.com', CAST(N'2021-10-24' AS Date), CAST(N'2021-10-24' AS Date), N'DELETED_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (14, N'Review nhanh iPhone 13 Pro Max: ngoại hình, cầm nắm và camera', N'Liệu những công nghệ mới nhất mà Apple trang bị trên chiếc iPhone xịn nhất của họ có mang lại trải nghiệm tốt hơn hay có đánh đổi gì không? ', N'Vẫn chỉnh chu và sắc sảo trong mọi đường nét. Từ thời iPhone X khi mà Apple chuyển sang dùng khung thép thay vì nhôm thì họ đã nâng mức độ hoàn thiện điện thoại lên một mức cao hơn. Và với dòng iPhone 12 Pro và 13 Pro thì thiết kế mới làm cho nó nhìn đẹp hơn, lung linh hơn. Trên thị trường anh em không tìm được chiếc điện thoại nào có mức độ hoàn thiện tốt hơn iPhone 13 Pro.

Có sự đánh đổi nhất định trong việc iPhone 13 Pro Max to và nặng. Thứ nhất là khu viền thép chắc chắn, bền bỉ, đẹp nên nó nặng hơn nhôm. Không có chiếc điện thoại nào hiện nay có thể bền bỉ về ngoại hình như là các chiếc iPhone viền thép cả, và nó chắc chắn liền khuôn nữa. Giá của nó là nặng.', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'ACTIVE_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (15, N'BẠN CÓ BIẾT NHỮNG SỰ THẬT NÀY VỀ BLEACH?', N'Bleach là một bộ manga nổi tiếng của tác giả Tite Kubo, kể về một thế giới không thấy được, nơi mà các ác linh và linh hồn tồn tại. Tại đó, có sự hiện diện của các Shinigami, nhiệm vụ của họ là tiêu diệt những linh hồn xấu ác làm hại con người và dẫn dắt các linh hồn trở về nơi của họ. Hôm nay, TinAnime sẽ gới thiệu đến các bạn 15 sự thật thú vị về bộ manga/anime ăn khách này, cùng đón xem nhé!', N'1. Ý nghĩa của tựa đề: "Bleach" có nghĩa là "chất tẩy trắng". Tên tựa đề này nhằm chỉ về sự tương phản với màu đen trên bộ đồ thần chết mặc, và cũng liên quan đến mô-típ Âm và Dương, như đen với trắng
2. Snipe: Khi lần đầu sáng tác Bleach, Kubo dự định sáng tác Rukia mang lưỡi hái, và các nhân vật khác sử dụng súng, nên tựa đề ban đầu của bộ manga này là "Snipe" (Súng bắn tỉa). Nhưng khi Kubo đổi vũ khí thành kiếm, nên tựa đề cũng phải được đổi theo. Và Kubo đã chọn tên "Bleach". Quả thật tên này rất ấn tượng đúng không các bạn!
3. Đam mê kiến trúc: Kubo rất đam mê kiến trúc, vì thế, tên của các Espada có gốc từ những kiến trúc sư nổi tiếng. Ví dụ như tên Ulquiorra đến từ nhà kiến trúc sư danh tiếng Patricia Urquiola.



', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'ACTIVE_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (16, N'österreich“映画”', N'真戸暁生誕祭2016', N'Tôi san sẻ bản thân
Cho cậu, vậy nên
Nếu cậu ra đi
Sẽ đau đớn như ai xé nát tâm can tôi
Sẽ như mất hồn
Thời gian ta bên nhau đã còn đâu, tôi tự hỏi
Bụi mờ
Phản chiếu ánh sáng
Đang rơi
Tôi tự hỏi liệu chúng có đến nơi nào tôi biết,
Nơi đó
Liệu còn có cậu,
Tôi tự nhủ
Cài tóc, trang sức và dầu thơm
Tôi đã bỏ chúng
Trong lãng quên tự lúc nào?
Chẳng còn lí do nữa
Và ngay cả khi tôi không hiểu điều đúng đắn
Thì cậu, vẫn luôn, là người đúng
Tôi vẫn luôn sai lầm và,
Tôi cũng sẽ để cậu như thế
"Mình thật vô dụng, phải không?"
"Mình chẳng cứu được ai cả"
Nếu cậu không muốn tôi đi
Thì tôi sẽ ở lại đây
Chân chẳng còn, đầu cũng mất
Nên tôi sẽ luôn ở lại đây
Sẽ luôn ở lại đây', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'ACTIVE_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (17, N'Mai', N'VideoClub', N'J''veux vivre et crier, marcher longtemps dans les rues
Observer les gens muets dans la chaleur du soir les bras nus
Me nourrir uniquement de la nuit, d''ses défauts et d''sa folie
Puis recommencer deux jours plus tard, faire ça toute ma vie
Monter en haut des toits, faire des portraits d''mes amis
Parler à des gens que je connais pas et m''en tirer sans trop d''ennuis
Voilà c''est ça c''que j''veux, des jours avec du soleil et de la pluie
', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'DELETED_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (18, N'久保帯人＆スタッフ', N'漫画家・久保帯人の公式アカウントです。 『BLEACH』『BURN THE WITCH』の情報を、 久保帯人本人と編集スタッフがつぶやきます。', N'再告知です！週刊少年ジャンプ36・37合併号に掲載された、久保帯人先生の新作読切の設定資料をFC限定で公開中！
未見の方は是非！

ここでしか見れない超貴重なイラストをお見逃しなく！
＜スタッフ＞', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'ACTIVE_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (19, N'Có thể hay không 可不可以', N'Trương Tử Hào ', N'说好带你流浪,而我却半路返航,坠落自责的海洋发现离不开你,我开始决定回去,你已不在原地我可以接受你的所有,所有小脾气我可以带你去吃很多,很多好东西我可以偶尔给你带来,带来小甜蜜就像前几年那样,每天都会给你制造很多惊喜你的心伤我能治愈,我的快乐也只有你能给予我们就别再分离可不可以和你在一起,我们之间有太多回忆爱上了你没什么道理,只是刚好情窦初开遇到你不希望我的未来不是你,只愿意和你永远不分离趁我还没有过保质期,趁你还愿意三年的回忆,我如何抹去,能不能再拾起永远在一起,还没有过期,我们就别再分离可不可以和你在一起,我们之间有太多回忆爱上了你没什么道理,只是刚好情窦初开遇到你不希望我的未来不是你,只愿意和你永远不分离趁我还没有过保质期,趁你还愿意', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'ACTIVE_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (20, N'Ngữ pháp JLPT N3 - てばかりいる – Cách sử dụng và Ví dụ', N'Dùng khi người nói có ý phê phán về chuyện sự việc đó cứ lặp đi lặp lại, hoặc lúc nào cũng nằm trong trạng thái đó. Không thay thế bằng だけ、のみ được.', N'Ý nghĩa: Suốt ngày, hoài. 試験が近いのに弟は遊んでばかりいる。
Sắp tới kỳ thì rồi, vậy mà em trai tôi cứ chỉ chơi thôi.
しけんがちかいのにおとうとはあそんでばかりいる。
Shiken ga chikainoni otōto wa asonde bakari iru.', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'DELETED_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (21, N'Ngữ pháp N3 - かな', N'Ý nghĩa: Liệu có phải…/ Có… không nhỉ? Đây là hậu tố thường đặt ở cuối câu để biểu hiện sự không chắc chắn, phân vân chưa có câu trả lời hoặc lo lắng về một việc gì đó (thường là người nói tự hỏi bản thân hoặc hỏi ý kiến người đối diện khi mình không chắc). Trong hội thoại hàng ngày chữ な thường được kéo dài ', N'②　彼、私のこと好きじゃないのかな…

→　Liệu anh ta có ghét tôi không nhỉ?', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'DELETED_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (22, N'Bom tấn ''Xứ cát 2'' có mỹ nam Timothée Chalamet đóng chính thức ''lăn bánh''', N'Theo The Hollywood Reporter ngày 26.10, phần tiếp theo của bom tấn Xứ cát (tựa tiếng Anh: Dune) được thực hiện, đạo diễn Denis Villeneuve tiếp tục lèo lái dự án', N'Phim kể về cuộc chiến của các gia tộc trên hành tinh Arrakis/Dune dưới thời trị vì của Hoàng đế. Lúc này, gia tộc Atreides được lệnh của Hoàng đế tiếp quản Arrakis, họ không biết những âm mưu hiểm độc đằng sau đó. Paul (Timothée Chalamet đóng), người sẽ dẫn dắt gia tộc Atreides sau này, cuối cùng đã phải lưu lạc cùng mẹ trên hành tinh cát vì nhà Atreides thất thế. Ngoài mỹ nam Timothée Chalamet, tác phẩm còn có sự góp mặt của dàn diễn viên Rebecca Ferguson, Josh Brolin, Dave Bautista, Oscar Isaac...

Tác phẩm nhận được nhiều khen ngợi của các cây bút phê bình điện ảnh, được chấm 84% trên trang Rotten Tomatoes và chứng nhận tươi. Phim Xứ cát 2 dự kiến xuất xưởng ngày 20.10.2023.', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'ACTIVE_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (23, N'Timothée Chalamet Wants You to Wear Your Heart on Your Sleeve', N'Timothée Chalamet, United States', N'Timothée Chalamet and I are on the run, chasing down Sixth Avenue on a bright September day in search of a place to talk. The restaurant in Greenwich Village where we had planned to meet ended up getting swarmed by NYU students while I was waiting for him, chattering excitedly to one another—“Timothée Chalamet is here!” “Shut up!” “Yeah, he’s right outside!”—so, trying to avoid a deluge of selfie seekers, I bolt from the table, tapping Chalamet on the shoulder where he stands under the awning, on the phone, and we make our escape. Face covered with a mask and hoodie pulled up over his curly hair, he’s mostly incognito but still cuts a distinct enough figure that we’d better find a new location fast, and standing at a crosswalk with him, I feel briefly protective, like I should be prepared to body-block an onslaught of fans at any moment.', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'NEW_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (24, N'久保帯人', N'久保 帯人（くぼ たいと、英: Tite Kubo、1977年〈昭和52年〉6月26日[1] - ）は、日本の漫画家。広島県安芸郡府中町出身[2]。府中町立府中緑ヶ丘中学校[3]、広島県立安芸府中高等学校卒業[3][4]。穴吹デザイン専門学校中退[要出典]。初期のペンネームは久保宣章（くぼ のりあき）であった。', N'前作の連載終了から1年後、『赤マルジャンプ』2001 WINTERに『BLEACH』のプロトタイプとなる読み切り版を掲載。同作は読者アンケートで1位を獲り[6]、連載が決定する。担当編集者として同作を立ち上げた浅田は、久保の描くキャラクターや世界観について「その当時の少年誌の中では圧倒的に新しかった」と評している[10]。

『BLEACH』は『週刊少年ジャンプ』2001年36・37合併号から2016年38号まで15年に渡り連載され[11]、シリーズ累計発行部数が、国内で9000万部、全世界で1億2000万部を突破する大ヒット作となった[12]。2005年に同作で第50回小学館漫画賞少年向け部門を受賞した。

また、『BLEACH』の連載と並行し、同作のスピンオフである『カラブリ』を『Vジャンプ』2005年01号から2007年09号まで連載した。

2008年7月24日からカリフォルニア州サンディエゴにて開催された、世界最大規模のコミック・コンベンションである「サンディエゴ・コミコン・インターナショナル」（Comic-Con International 2008）にゲスト参加。インクポット賞を受賞した[13]。現地のファンと交流した際には、イベント開始2時間以上前から会場前に行列ができ入場できなかったファンもいたほどであり、久保はそこで初めてアメリカでの人気の高さを知ったという. 久保は長期連載による疲れから体調を崩しており、当初「15年も描いたんで、15年は休みたいです」と語っていたが[16]、『BLEACH』完結以来2年ぶりの新作となる読切作品『BURN THE WITCH』を『週刊少年ジャンプ』2018年33号に掲載した[17][18]。

2019年には『BLEACHイラスト集 JET』の発売にあたり、国内では「ジャンプフェスタ2001」以来17年ぶりとなるサイン会を開催[19]。同年にはメインキャラクターデザインを担当したPlayStation 4用ゲーム『新サクラ大戦』が発売された[20]。

2020年より『BLEACH』20周年プロジェクトの一環として、『週刊少年ジャンプ』で『BURN THE WITCH』のシリーズ連載を開始[21]。Season1は2020年38号から41号まで短期集中連載され、劇場中編アニメーションも制作された[22]。

『BLEACH』20周年プロジェクトでは、久保にとって初の原画展覧会となる「BLEACH EX.」の開催が決定されている[23][24]。また、2021年1月18日より久保帯人公式ファンクラブサイト『Klub Outside』を1年間の期間限定で開設した[25][26]。『BLEACH』が連載開始20周年を迎えた『週刊少年ジャンプ』2021年36・37合併号に、『BLEACH』本編完結後のエピソードが描かれた新作読切を掲載した', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'NEW_ARTICLE')
INSERT [dbo].[Article] ([ArticleID], [Title], [ShortDescription], [Content], [Email], [CreatingDate], [PostingDate], [Status]) VALUES (25, N'Nơ', N'Một cô gái illusion khi vừa mới chia tay với người yêu xong. Và rồi cô ấy kỳ vọng vào tôi là người yêu thế nhưng rốt cuộc cô ấy coi tôi chỉ là một người qua đường', N'Đọc một cuốn sách hay, đến vài năm sau lật lại chỉ thấy nhạt.
À ra là không hàm chứa tâm tư mình nữa.', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date), CAST(N'2021-10-29' AS Date), N'NEW_ARTICLE')
SET IDENTITY_INSERT [dbo].[Article] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (1, 3, N'okie', N'knightfxcker@gmail.com', CAST(N'2021-10-24' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (2, 3, N'mua liền cho nóng', N'knightfxcker@gmail.com', CAST(N'2021-10-24' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (3, 3, N'ổnnnn', N'knightfxcker@gmail.com', CAST(N'2021-10-24' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (4, 3, N'To change beliefs suddenly from something to its complete opposite', N'knightfxcker@gmail.com', CAST(N'2021-10-25' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (5, 3, N'The current prime minister thinks it is a joke to volte face on the plans that he announces publicly.', N'knightfxcker@gmail.com', CAST(N'2021-10-25' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (6, 3, N'Lần cuối', N'knightfxcker@gmail.com', CAST(N'2021-10-25' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (10, 3, N'Nhân dịp tụi mình ra sự kiện festival biển Nha Trang vừa rồi nên sẵn làm bài đánh giá chi tiết về hiệu năng cũng như chất lượng thực sự của chiếc A6400 này đối với các ảnh chụp hằng ngày trong các điều kiện chụp, ánh sáng khác nhau, ảnh và quay sân khấu với ánh sáng thay đổi... hay kể cả các hoặt động thể thao cho các bạn tham khảo thêm, nhất là thử chi tiết chế độ "Real-time Eye AF” và ”Real-time Tracking" cũng như khả năng quay liên tục trên chiếc máy này.', N'knightfxcker@gmail.com', CAST(N'2021-10-26' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (11, 3, N'Cây hài
zui', N'knightfxcker@gmail.com', CAST(N'2021-10-26' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (12, 17, N'j''apprécie 😍', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (13, 14, N'Muaaaaa lẹ không kẻo hết :((((((', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (14, 22, N'My Idol 😍', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (15, 16, N'Một thời cuồng TK và dĩ nhiên là bà Akira vẫn là girl trong lòng tôi mãi mãi :3', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (16, 15, N'Con chiên của Bleach mà liệu =)))', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (17, 18, N'Okk', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (18, 19, N'Nghe bài này để có động lực khi lỡ lọt hố vs ai :P 😂', N'lanlnhse140961@fpt.edu.vn', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (19, 15, N'Bleach sắp ra Anime vào năm sau kìaaaa', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date))
INSERT [dbo].[Comment] ([CommentID], [ArticleID], [Content], [Email], [Date]) VALUES (20, 22, N'Hóng', N'knightfxcker@gmail.com', CAST(N'2021-10-29' AS Date))
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (N'ADMIN', N'Admin')
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (N'MEMBER', N'Member')
GO
INSERT [dbo].[StatusArticle] ([StatusID], [StatusName]) VALUES (N'ACTIVE_ARTICLE ', N'Active')
INSERT [dbo].[StatusArticle] ([StatusID], [StatusName]) VALUES (N'DELETED_ARTICLE', N'Deleted')
INSERT [dbo].[StatusArticle] ([StatusID], [StatusName]) VALUES (N'NEW_ARTICLE', N'New')
GO
INSERT [dbo].[StatusUser] ([StatusID], [StatusName]) VALUES (N'ACTIVE_ACCOUNT', N'Active')
INSERT [dbo].[StatusUser] ([StatusID], [StatusName]) VALUES (N'NEW_ACCOUNT', N'New')
GO
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Code], [Status]) VALUES (N'kazuocyrus@gmail.com', N'Cyrus Le', N'ba0a384d53852c2784d4d42e7a5ccd1184b22524f5c739c24e0615ec3c683042', N'ADMIN', N'470827', N'ACTIVE_ACCOUNT')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Code], [Status]) VALUES (N'knightfxcker@gmail.com', N'December Knight', N'96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e', N'MEMBER', N'395552', N'ACTIVE_ACCOUNT')
INSERT [dbo].[User] ([Email], [Name], [Password], [Role], [Code], [Status]) VALUES (N'lanlnhse140961@fpt.edu.vn', N'Lê Nhật Hạnh Lan', N'ba0a384d53852c2784d4d42e7a5ccd1184b22524f5c739c24e0615ec3c683042', N'MEMBER', N'035725', N'ACTIVE_ACCOUNT')
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_StatusArticle] FOREIGN KEY([Status])
REFERENCES [dbo].[StatusArticle] ([StatusID])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_StatusArticle]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD  CONSTRAINT [FK_Article_User] FOREIGN KEY([Email])
REFERENCES [dbo].[User] ([Email])
GO
ALTER TABLE [dbo].[Article] CHECK CONSTRAINT [FK_Article_User]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_Article] FOREIGN KEY([ArticleID])
REFERENCES [dbo].[Article] ([ArticleID])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_Article]
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD  CONSTRAINT [FK_Comment_User] FOREIGN KEY([Email])
REFERENCES [dbo].[User] ([Email])
GO
ALTER TABLE [dbo].[Comment] CHECK CONSTRAINT [FK_Comment_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([Role])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_StatusUser] FOREIGN KEY([Status])
REFERENCES [dbo].[StatusUser] ([StatusID])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_StatusUser]
GO
USE [master]
GO
ALTER DATABASE [SimpleBlog] SET  READ_WRITE 
GO
