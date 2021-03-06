//
//  RecentPostsInteractor.swift
//  SuperNewsSB
//
//  Created by Luis Zapata on 12-01-20.
//  Copyright (c) 2020 Luis Zapata. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol RecentPostsBusinessLogic
{
    func fetchRecentPosts()
    func removePost(index: Int, id: String)
}

protocol RecentPostsDataStore
{
    //var displayedPosts: [PostsModel.Recent.ViewModel.DisplayedPost] { get set }
}

class RecentPostsInteractor: RecentPostsBusinessLogic, RecentPostsDataStore
{
    
    var presenter: RecentPostsPresentationLogic?
    var worker: RecentPostsWorker?
    typealias DisplayedPost = PostsModel.Recent.ViewModel.DisplayedPost

    func removePost(index: Int, id: String) {
        var deletedPosts = defaults.getStringArray(key: .deletedPosts)
        deletedPosts.append(id)
        defaults.set(key: .deletedPosts, value: deletedPosts)
    }
    
    func fetchRecentPosts()
    {
        worker = RecentPostsWorker()
        worker?.requestRecentPosts() { (response, error) -> Void in
            if response != nil {
                var viewModel: [DisplayedPost] = []
                let deletedPosts = self.worker!.retrieveDeletedPosts()
                for post in response!.hits! {
                    if post.story_title != nil && post.story_url != nil && !deletedPosts.contains(post.objectID){
                        viewModel.append(DisplayedPost.init(id: post.objectID,
                                                            createdAt: Date(timeIntervalSince1970: post.created_at_i),
                                                            author: post.author,
                                                            storyTitle: post.story_title!,
                                                            storyUrl: post.story_url!))
                    }
                }
                self.worker!.storeRecentPost(posts: viewModel)
                self.presenter?.presentPosts(viewModel: viewModel)
            } else {
                self.presenter?.presentPosts(viewModel: self.worker?.retrieveRecentPosts() ?? [])
            }
        }
        

    }
}
