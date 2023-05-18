
#include <stdio.h>
#include <vector>

#include <boost/random.hpp>

boost::mt19937 rng (time(0));
// on range [min, max]
int randInt(int min, int max)
{
    boost::uniform_int<int> u(min, max);
    boost::variate_generator<boost::mt19937&, boost::uniform_int<int> > gen(rng, u);
    return gen();
}


class WF
{
public:
    enum type
    {
        a,
        b,
        c,
        d,
        superposition,
    };

    unsigned int entropy()
    {
        return this->states.size() - 1;
    }

    WF()
    {
        this->states = {a, b, c, d};
        this->type_ = superposition;
    }

    WF(std::vector<type> states)
    {
        this->states = states;
        if (this->entropy())
        {
            this->type_ = superposition;
        }
        else
        {
            this->type_ = this->states[0];
        }
    }

    enum type Type()
    {
        return this->type_;
    }

private:
    enum type type_;
    std::vector<type> states;
};

class TileField
{
public:
    TileField(int width, int height)
    {
        this->tiles = new WF *[width];
        for (int i = 0; i < width; i++)
        {
            this->tiles[i] = new WF[height];
        }
        this->tiles[this->width - 1][randInt(0, this->height - 1)] = WF({static_cast<WF::type>(WF::superposition - 1)});
        this->width = width;
        this->height = height;
    }

    void Shift()
    {
        delete this->tiles[0];
        for (int i = 0; i < this->width - 1; i++)
        {
            this->tiles[i] = this->tiles[i + 1];
        }
        this->tiles[this->width - 1] = new WF[height];
    }

    void print()
    {
        for(int y = 0; y < this->height; y++)
        {
            for(int x = 0; x < this->width; x++)
            {
                printf("%d ", this->tiles[x][y].Type());
            }
            printf("\n");
        }
    }

private:
    int width, height;
    WF **tiles;
    std::vector<std::vector<WF *>> tilesByEntropy;
};

int main()
{
    TileField f = TileField(10, 10);
    f.print();
    printf("hello word\n");
}