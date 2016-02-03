#include "singleton.h"
#include "singletonB.h"

/*
   自己区分singleton和singletonB的区别，
   singleton能继承，singletonB不能继承
   */
class Test : public Singleton<Test> {
public:
	void play() {cout << "play!" << endl;}
};


class TestB  {
public:
	void play() {cout << "playB" << endl;}
};


int main(int argc, char *argv[]) {
	//
	typedef SingletonB<TestB> TestB;
	TestB::instance().play();


	Test::instance().play();	


	//Test t;
	//t.play();
	return 0;
}
