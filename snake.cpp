#include <iostream>
#include <conio.h>
#include <windows.h>
using namespace std;

bool gameover;

const int width = 20;
const int height = 17;
int delay = 200;//[millisecond]
int x, y, fruitX, fruitY, score;

//snake coordinates
int tailX[100], tailY[100];
int nTail;

// Controls
enum eDirecton {
	STOP	=  0,
	LEFT	= 75,
	RIGHT	= 77,
	UP	= 72,
	DOWN	= 80
}; 

eDirecton dir;

void Setup() {
	gameover = false;

	dir = STOP;

	x = width / 2;

	y = height / 2;

	fruitX = rand() % width; //display fruit in a random place

	fruitY = rand() % height; score = 0;

}

void Draw() {
	system("cls");

	for (int i = 0; i < width + 2; i++)
		cout << "#";
	cout << endl;

	for (int i = 0; i < height; i++) {
		for (int j = 0; j < width; j++) {
			if (j == 0)
				cout << "#"; //walls

			if (i == y && j == x)
				cout << "@"; // snake tale
			else if (i == fruitY && j == fruitX)
				cout << "$"; // change it to change the fruit
			else {
				bool print = false;
				for (int k = 0; k < nTail; k++) {
					if (tailX[k] == j && tailY[k] == i) {
						cout << "*";
						print = true;
					}
				}
				if (!print)
					cout << " ";
			}
			if (j == width - 1)
				cout << "#";
		}
		cout << endl;
	}

	for (int i = 0; i < width + 2; i++)
		cout << "#";
	cout << endl;

	cout << "Score:" << score << endl;
}

void Input()
{
	int key;
	if (_kbhit()) {
		key = getch();
		if(key == 'x')
			gameover = true;
		else{
			key = getch();
			switch (key) {
			case LEFT:
				dir = LEFT;
				break;
			case RIGHT:
				dir = RIGHT;
				break;
			case UP:
				dir = UP;
				break;
			case DOWN:
				dir = DOWN;
				break;
			}
		}
	}
}

void algorithm()
{
	int prevX = tailX[0];
	int prevY = tailY[0];
	int prev2X, prev2Y;

	tailX[0] = x;
	tailY[0] = y;

	for (int i = 1; i < nTail; i++) {
		prev2X = tailX[i];
		prev2Y = tailY[i];
		tailX[i] = prevX;
		tailY[i] = prevY;
		prevX = prev2X;
		prevY = prev2Y;
	}

	switch (dir) {
	case LEFT:
		x--;
		break;
	case RIGHT:
		x++;
		break;
	case UP:
		y--;
		break;
	case DOWN:
		y++;
		break;
	default:
		break;
	}

	if (x >= width)
		x = 0;
	else if (x < 0)
		x = width - 1;

	if (y >= height) y = 0; else if (y < 0)
		y = height - 1;

	for (int i = 0; i < nTail; i++)
		if (tailX[i] == x && tailY[i] == y)
			gameover = true;

	if (x == fruitX && y == fruitY) {
		score += 10;
		fruitX = rand() % width;
		fruitY = rand() % height;
		nTail++;
	}
}

int main()
{
	Setup();
	while (!gameover) {
		Draw();
		Input();
		algorithm();
		Sleep(delay);
	}
	return 0;
}
