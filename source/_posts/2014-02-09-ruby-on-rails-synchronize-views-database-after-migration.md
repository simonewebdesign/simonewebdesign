---
title: 'Rails 4: update/synchronize views with database schema after a migration'
author: Simone Vittori
layout: post
permalink: /blog/ruby-on-rails-synchronize-views-database-after-migration/
dsq_thread_id:
  - 2243561731
categories:
  - Rails
tags:
  - activerecord
  - changes
  - database
  - migrate
  - migration
  - ruby on rails
  - schema
  - synchronize
  - view
---
<div id="jbID-1178" class="jbPost">
  <p>
    So you just updated your model and the related database schema, but your views are now obsolete. How to refresh them?
  </p>
  
  <p>
    Well, there are a lot of premises to say here. First, <strong>there&#8217;s no actual way to synchronize your views with your model.</strong> The best way is to <strong>do it manually</strong>, but it&#8217;s not the <em>only</em> way. The other way, which I&#8217;m going to explain in this post, actually only works if you are willing to <em>scaffold</em> your whole model/view/controller/tests from scratch. This is probably not desirable in most of cases, but I assure you can safely try this path if you are in a early stage of development, or if you are ok with the default (generated) Rails&#8217; views. So, whatever, if you don&#8217;t want to <code>rake generate scaffold your_resource</code> again, you can stop reading now. <hr />
    
    <p>
      Oh well, you are still reading :-)
    </p>
    
    <p>
      I&#8217;ll proceed explaining how to synchronize your views after the migration(s) you have run. Let&#8217;s just start from scratch.
    </p>
    
    <h2>
      A full example
    </h2>
    
    <p>
      Let&#8217;s say we have these two models: <code>Child</code> and <code>Toy</code>.
    </p>
    
    <h5>
      Child
    </h5>
    
    <ul>
      <li>
        name
      </li>
      <li>
        birth_date
      </li>
    </ul>
    
    <h5>
      Toy
    </h5>
    
    <ul>
      <li>
        description
      </li>
      <li>
        price
      </li>
      <li>
        child_id
      </li>
    </ul>
    
    <p>
      As you might have already guessed, I am going to tie our models with a <em>one-to-many</em> relationship: a child <code>has_many</code> toys, and a toy <code>belongs_to</code> a child.
    </p>
    
    <h5>
      app/models/child.rb
    </h5>
    
    <pre>
class Child &lt; ActiveRecord::Base
  has_many :toys
end
</pre>
    
    <h5>
      app/models/toy.rb
    </h5>
    
    <pre>
class Toy &lt; ActiveRecord::Base
  belongs_to :child
end
</pre>
    
    <p>
      Let's create the application and scaffold these resources:
    </p>
    
    <pre>$ rails new DemoApp &#038;&#038; cd DemoApp</pre>
    
    <pre>
$ rails generate scaffold child name birth_date:date

$ rails generate scaffold toy description price:decimal child:references
</pre>
    
    <p>
      Run the migrations:
    </p>
    
    <pre>
$ rake db:migrate
==  CreateChildren: migrating =================================================
-- create_table(:children)
   -> 0.0014s
==  CreateChildren: migrated (0.0015s) ========================================

==  CreateToys: migrating =====================================================
-- create_table(:toys)
   -> 0.0028s
==  CreateToys: migrated (0.0029s) ============================================
</pre>
    
    <p>
      We can now start the server and check that everything went good.
    </p>
    
    <pre>
$ rails s
=> Booting WEBrick
=> Rails 4.1.0.beta1 application starting in development on http://0.0.0.0:3000
...
</pre>
    
    <img src="http://simonewebdesign.it/blog/wp-content/uploads/2014/02/Screen-Shot-2014-02-09-at-14.33.54.png" alt="listing children empty" class="alignnone size-medium wp-image-1184" /> <p>
      It looks fine, except for one thing: there's no data displayed! Let's add some entries manually.
    </p>
    
    <img src="http://simonewebdesign.it/blog/wp-content/uploads/2014/02/Screen-Shot-2014-02-09-at-14.36.57.png" alt="listing children" class="alignnone size-medium wp-image-1185" /> <p>
      Good. Now let's give some toys to our boys:
    </p>
    
    <img src="http://simonewebdesign.it/blog/wp-content/uploads/2014/02/Screen-Shot-2014-02-09-at-15.30.02.png" alt="toy successfully created" class="alignnone size-medium wp-image-1188" /> <p>
      Done. But wait a minute: this view looks a bit... crappy, doesn't it? We don't want to see a reference to a child... just his/her name. Even the prices don't look right.
    </p>
    
    <p>
      Let's generate the scaffold again, with some corrections.
    </p>
    
    <pre>$ rails g scaffold toy description:string{50} price:decimal{4,2} 
      invoke  active_record
Another migration is already named create_toys: /Users/simo/Projects/DemoApp/db/migrate/20140209145850_create_toys.rb. Use --force to remove the old migration file and replace it.</pre>
    
    <p>
      Fair enough. We must destroy the entire scaffold before recreating it.
    </p>
    
    <pre>$ rails destroy scaffold toy
      invoke  active_record
      remove    db/migrate/20140208224426_create_toys.rb
      remove    app/models/toy.rb
      remove    ...

$ rails generate scaffold toy description:string{50} price:decimal{4,2} child:references
      invoke  active_record
      create    db/migrate/20140209145850_create_toys.rb
      create    app/models/toy.rb
      create    ...
</pre>
    
    <p>
      Ok. Let's give a quick look at the generated migration.
    </p>
    
    <pre>
class CreateToys &lt; ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.string :description, limit: 50
      t.decimal :price, precision: 4, scale: 2
      t.references :child, index: true

      t.timestamps
    end
  end
end
</pre>
    
    <p>
      It looks right. Let's run it!
    </p>
    
    <pre>$ rake db:migrate
==  CreateToys: migrating =====================================================
-- create_table(:toys)
rake aborted!
An error has occurred, this and all later migrations canceled:

SQLite3::SQLException: table "toys" already exists: CREATE TABLE "toys" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar(50), "price" decimal(4,2), "child_id" integer, "created_at" datetime, "updated_at" datetime) /Users/simo/.rvm/gems/ruby-2.0.0-p353/gems/sqlite3-1.3.8/lib/sqlite3/database.rb:91:in `initialize'</pre>
    
    <p>
      Whoops! The table already exists. We should remove it first. Edit the migration:
    </p>
    
    <pre>
class CreateToys &lt; ActiveRecord::Migration
  def change
    # This will do the work
    drop_table :toys

    create_table :toys do |t|
      t.string :description, limit: 50
      t.decimal :price, precision: 4, scale: 2
      t.references :child, index: true

      t.timestamps
    end
  end
end
</pre>
    
    <p>
      And migrate again:
    </p>
    
    <pre>$ rake db:migrate
==  CreateToys: migrating =====================================================
-- drop_table(:toys)
   -> 0.0107s
-- create_table(:toys)
   -> 0.0109s
==  CreateToys: migrated (0.0220s) ============================================</pre>
    
    <p>
      Ok, we are ready to start the server again and see what changed.
    </p>
    
    <pre>$ rails s</pre> That's it. This is basically the process. It's way too labourious, I know, but the truth is that we just can't efficiently automatize a process like this, because: what if we generate more migrations during the journey? We would have to delete them and recreate again the whole schema by running 
    
    <code>rails generate scaffold</code>, <code>rake db:reset</code> and rerun the generate again and again... well, that sucks. At this stage we've got the point: it's better to do it manually! Rails gives us tons of helper methods to format prices and get things done, and that's definitely the path to follow.
  </p>
  
  <p>
    If you are still not convinced, you can check this <a href="https://stackoverflow.com/questions/1732135/question-regarding-rails-migration-and-synchronizing-views" target="_blank">question on StackOverflow</a>. Basically, it's almost the same question I had before writing this post. Both the question and the answer are quite old, and in the meantime the Rails Team didn't develop anything that would help us regenerating our views. This probably means <strong>we are not supposed to do it</strong>, don't you think? However, if your goal is to get focused on the backend without having to deal with the frontend, you can always use a gem like <a href="https://github.com/activescaffold/active_scaffold" title="Save time and headaches, and create a more easily maintainable set of pages, with ActiveScaffold. ActiveScaffold handles all your CRUD (create, read, update, delete) user interface needs, leaving you more time to focus on more challenging (and interesting!) problems." target="_blank"><code>ActiveScaffold</code></a>. But you have been warned!
  </p>
  
  <p>
    I hope you've found this article useful; thoughts are welcome, as always. If you want you can leave a comment below.
  </p>
</div>