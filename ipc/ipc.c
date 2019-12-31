
#include<stdio.h>
#include<windows.h>
#include<process.h>

#define N 5
#define LEFT(i) ((i) + N - 1) % N
#define RIGHT(i) ((i) + 1) % N
#define THINKING 0
#define HUNGRY 1
#define EATING 2

int state[N];
HANDLE mutex;
HANDLE semaphore[N];
HANDLE semPar;
int eattime[N] = {2000,1000,4000,2000,3000};
int thinkingtime[N] = {1000,3000,3000,2000,4000};
void thinking(int i);
void eating(int i);
void take_forks(int i);
void put_forks(int i);
void test(int i);
void print_state(void);

unsigned int __stdcall philosopher(void *pM)
{
    int i,cnt = 3;
    i = *(int*)pM;
    ReleaseSemaphore(semPar, 1, NULL);
    while(cnt--)
    {
        thinking(i);
        take_forks(i);
        eating(i);
        put_forks(i);
    }
    printf("                  哲学家[%d]线程结束\n", i);
    return 0;
}

void take_forks(int i)
{
    WaitForSingleObject(mutex, INFINITE);
    state[i] = HUNGRY;
    test(i);
    ReleaseSemaphore(mutex, 1, NULL);
    WaitForSingleObject(semaphore[i], INFINITE);
}

void put_forks(int i)
{
    WaitForSingleObject(mutex, INFINITE);
    state[i] = THINKING;
    test(LEFT(i));
    test(RIGHT(i));
    ReleaseSemaphore(mutex, 1, NULL);
}

void test(int i)
{
    if(state[i] == HUNGRY && state[LEFT(i)] != EATING && state[RIGHT(i)] != EATING)
    {
        state[i] = EATING;
        ReleaseSemaphore(semaphore[i], 1, NULL);
    }
}

void eating(int i)
{
    printf("哲学家[%d]开始就餐\n", i);
    Sleep(eattime[i]);
    printf("哲学家[%d]结束就餐\n\n", i);
}

void thinking(int i)
{
    Sleep(thinkingtime[i]);
 }

void print_state(void)
{
    int i;
    for(i = 0;i < N;i++)
    {
        printf("%d ", state[i]);
    }
    printf("\n");
}

int main()
{
    int i;
    HANDLE thread[N];
    mutex = CreateSemaphore(NULL, 1, 1, NULL);

    for(i = 0;i < N;i++)
    {
        semaphore[i] = CreateSemaphore(NULL, 0, 1, NULL);
    }

    semPar = CreateSemaphore(NULL, 0, 1, NULL);

    for(i = 0;i < N;i++)
    {
        thread[i] = (HANDLE)_beginthreadex(NULL, 0,philosopher, &i, 0, NULL);
        WaitForSingleObject(semPar, INFINITE);
    }
    WaitForMultipleObjects(N, thread, TRUE, INFINITE);
    system("pause");
    return 0;
}
