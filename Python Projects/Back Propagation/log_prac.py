from __future__ import print_function
import tensorflow as tf
# Import MNIST data
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets("/home/sunbro/Desktop/Numerals/", one_hot=True)
#The result is that mnist.train.imagesisa tensor (an n-dimensional array) with a shape of [55000, 784]
#one-hot vector is a vector which is 0 in most dimensions, and 1 in a single dimension. 
# 1  will be the the column number  5 would be [0,0,0,0,0,1,0,0,0,0]

learning_rate = .9
training_epochs = 100
batch_size = 100
step = 10


#input- shape 'None' states that, the value can be anything, i.e we can feed in any number of images
x = tf.placeholder(tf.float32, [None, 784]) # mnist data image of shape 28*28=784
y = tf.placeholder(tf.float32, [None, 10]) # 0-9 digits recognition => 10 classes
# x isn't a specific value. It's a placeholder, a value that we'll input when we ask TensorFlow to run a computatio

#we initialize both W and b as tensors full of zeros
# Set model weights
W = tf.Variable(tf.zeros([784, 10]))
b = tf.Variable(tf.zeros([10]))


# Construct model
Y_pred = tf.nn.softmax(tf.matmul(x, W) + b) 
# Softmax used as we have more then 2 classes

# Minimize error using cross entropy
#y is the ground truth
#Y_pred is our predicted prob
cost = tf.reduce_mean(-tf.reduce_sum(y*tf.log(Y_pred), reduction_indices=1))
#1)tf.log(Y_pred) computes log of each element of y
#2) then y is mult with tf.log(Y_pred) 


# Gradient Descent
#gradient descent basically applies learning rate to get to the best line fit for our data as Each gradient decent algo  iteration w and b are updated to values  that yield slightly lower cost error than the previous iteration. 
optimizer = tf.train.GradientDescentOptimizer(learning_rate).minimize(cost)

# Initialize the variables (i.e. assign their default value)
init = tf.global_variables_initializer()

# Start training
sess= tf.Session() 
# Run the initializer
sess.run(init)

for epoch in range(training_epochs):
        avg_cost = 0
        total_batch = int(mnist.train.num_examples/batch_size)#dividing into batches
        #print("number of total_batch", total_batch)

        for i in range(total_batch):
            batch_xs, batch_ys = mnist.train.next_batch(batch_size)
            # Run optimization op (backprop) and cost op (to get loss value)
            # cst is the cost
            _, cst = sess.run([optimizer, cost], feed_dict={x: batch_xs,
                                                          y: batch_ys})

             # Compute average loss 
            avg_cost += cst / total_batch

        if (epoch+1) % step == 0:
            print("Epoch:", '%04d' % (epoch+1), "cost=", "{:.4f}".format(avg_cost))


print("Optimization completed!")

    # Test model
#check if our prediction matches the ground truth 
correct_prediction = tf.equal(tf.argmax(Y_pred, 1), tf.argmax(y, 1))

print("\n\n")
print(tf.argmax(Y_pred,1))
print(Y_pred)
print("\n\n")

print(correct_prediction)
    # Calculate accuracy
 #what fraction are correct, we cast to floating point numbers and then take the mean
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

#Finally, we ask for our accuracy on our test data
print("Accuracy:", accuracy.eval(session=sess,feed_dict={x: mnist.test.images, y: mnist.test.labels}))


sess.close()
