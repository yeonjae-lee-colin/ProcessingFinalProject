# ProcessingFinalProject
2018 UX programming final project

# Introduction


### Title
Time is illusion
### Interaction
It works with user's mouse interaction.
- click mouse for generating a new time line.
- hold and drag mouse in vertical direction will reverse time lines.
- press 'r' key to delete them all.

# Concept

아인슈타인은 상대성이론을 정립하면서 시간은 절대적인 기준이 아니라 상대적인 기준으로 존재함에 대해 설명하였다. 즉, 빠르게 움직이고 있는 공간일 수록 시간은 느리게 흘러간다는 것이다. 우리가 평소 시간을 구분할 때 사용하는 과거, 현재, 미래라는 개념에 비추어 보았을 때, 과거는 이미 사라져 버린 시간이며, 현재는 지금 순간 그리고 미래는 아직 일어나지 않은 시간이라고 여긴다. 하지만 앞서 말한 ‘상대적 시간’의 개념을 적용하였을 때 3가지 시점이 독립적으로 존재한다는 것은 우리가 만들어낸 환영일 지도 모른다. 이러한 아인슈타인의 상대성 이론에서 착안하여 ‘과거, 현재, 미래’라는 개념에 대해 재 고찰하고 프로그램 사용자들 또한 인터렉션을 통해 ‘시간’과 ‘내가 마주하고있는 시간은 어디서로부터 비롯되었는가?’에 관해 생각해볼 수 있도록 한다.

**과거, 현재, 미래의 경계** 
> 가령 서로 다른 시간기준계를 가진 A,B 공간이 있고 각각 오른쪽 방향, 왼쪽 방향으로 반대로 움직이고 있다고 가정했을 때, A(→ )의 입장에서 B(←)의 과거는 A 의 미래이며 B 의 미래는 A 의 과거이며 그 반대의 경우도 마찬가지 이다. 따라서 과거, 현재,미래는 동시에 존재하고 있을지 모른다는 것을 의미한다.

**타임라인**
> 우리는 시간이 흐르는 동안 수많은 행동을 한다. 이와 같이 의미 있는 시간들을 타임라인으로 정의하였으며 타임라인은 어떤 행동을 시작하는 시점에 생성된다. 해당 시점으로부터 시작한 시간은 무한히 흐르며 보이지 않는 흔적을 남긴다는 것을 표현하려 한다.

# Visualiztion
![alt text][file2]
![alt text][file1]

[file2]:https://github.com/201511045/ProcessingFinalProject/blob/master/res/File2.png 
[file1]: https://github.com/201511045/ProcessingFinalProject/blob/master/res/File1.png  "Figure2"

배경에서 움직이는 작은 파티클들은 다른 의미하며 화면은 4차원 시공간을 배경으로 한다. 사용자들의 인터렉션을 통해 생성된 타임라인들을 사용자의 마우스 클릭 동작에 따라 타임라인이 생성되며 각 타임라인은 생성시각의 timestamp 정보를 가진다. 이때 사용자의 행동(개입)에 의해 결정된 timestamp에 따라 타임라인의 이동 속도, v색깔, 크기가 결정되는데, 클릭 기점을 시작으로 타임라인은 계속 이동하며 시간은 끝없이 흐름을 보여준다. 마우스를 누른 상태에서 좌/우로 드래그 한 후 클릭을 해제했을 때 타임라인의 이동 방향이 반대로 바뀌는데, 이 행위를 통해 이전에 과거라고 여겼던 시간들이 지금 시각에서는 미래가 될 수 있음을 관찰하고 제목인 ‘Time is illusion’의 의미를 전달한다. [Figure 1]
x, y축으로 마우스의 움직임이 있을 때 화면에 나타나는 선들은 타임라인의 흔적을 보여주며, 비록 화면에 타임라인이 보이지 않더라도 시간은 계속 흐르고 있음을 보여준다. 또한 마우스를 제자리에서 길게 누르는 동작을 통해 빠르게 움직이던 타임라인을 멈추고 timestamp를 확인할 수 있다. 마지막으로, 키보드 ‘r’키를 눌러 프로그램을 초기화 하고 재시작 할 수 있다. [Figure 2]

![alt text][file3]
![alt text][file4]

[file3]:https://github.com/201511045/ProcessingFinalProject/blob/master/res/File3.png "Figure1"
[file4]:https://github.com/201511045/ProcessingFinalProject/blob/master/res/File4.png

